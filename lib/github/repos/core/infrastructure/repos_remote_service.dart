import 'package:dio/dio.dart';

import '../../../../core/infrastructure/dio_extension.dart';
import '../../../../core/infrastructure/network_exception.dart';
import '../../../../core/infrastructure/remote_response.dart';
import '../../../core/infrastructure/github_headers.dart';
import '../../../core/infrastructure/github_headers_cache.dart';
import '../../../core/infrastructure/github_repo_dto.dart';

typedef JsonSelector = List<dynamic> Function(dynamic json);

abstract class ReposRemoteService {
  final Dio _dio;
  final GithubHeadersCache _headersCache;

  ReposRemoteService(this._dio, this._headersCache);

  Future<RemoteResponse<List<GithubRepoDTO>>> getPage({
    required Uri requestUri,
    required JsonSelector jsonDataSelector,
  }) async {
    final previousHeaders = await _headersCache.getHeaders(requestUri);

    try {
      final response = await _dio.getUri(requestUri,
          options: Options(
            headers: {'If-None-Match': previousHeaders?.etag ?? ''},
          ));
      if (response.statusCode == 304) {
        return RemoteResponse.notModified(
          maxPage: previousHeaders?.link?.maxPage ?? 0,
        );
      } else if (response.statusCode == 200) {
        final headers = GithubHeaders.parse(response);
        await _headersCache.saveHeaders(requestUri, headers);
        final convertedData =
            jsonDataSelector(response.data).map((e) => GithubRepoDTO.fromJson(e as Map<String, dynamic>)).toList();

        return RemoteResponse.withNewData(
          convertedData,
          maxPage: headers.link?.maxPage ?? 1,
        );
      } else {
        throw RestApiException(response.statusCode);
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return const RemoteResponse.noConnection();
      } else if (e.response != null) {
        throw RestApiException(e.response?.statusCode);
      } else {
        rethrow;
      }
    }
  }
}
