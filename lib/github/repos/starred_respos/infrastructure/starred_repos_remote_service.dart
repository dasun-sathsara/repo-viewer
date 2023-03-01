import 'package:dio/dio.dart';

import '../../../../core/infrastructure/remote_response.dart';
import '../../../core/infrastructure/github_headers_cache.dart';
import '../../../core/infrastructure/github_repo_dto.dart';
import '../../../core/infrastructure/pagination_config.dart';
import '../../core/infrastructure/repos_remote_service.dart';

class StarredReposRemoteService extends ReposRemoteService {
  StarredReposRemoteService(Dio dio, GithubHeadersCache headersCache) : super(dio, headersCache);

  Future<RemoteResponse<List<GithubRepoDTO>>> getStarredReposPage(int page) async {
    return super.getPage(
        requestUri: Uri.https(
          'api.github.com',
          '/user/starred',
          {
            'page': '$page',
            'per_page': PaginationConfig.itemsPerPage.toString(),
          },
        ),
        jsonDataSelector: (json) => json as List<dynamic>);
  }
}
