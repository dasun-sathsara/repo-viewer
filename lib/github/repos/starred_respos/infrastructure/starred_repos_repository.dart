import 'package:fpdart/fpdart.dart';

import '../../../../core/domain/fresh.dart';
import '../../../../core/infrastructure/network_exception.dart';
import '../../../core/domain/github_failure.dart';
import '../../../core/domain/github_repo.dart';
import '../../core/infrastructure/extensions.dart';
import 'starred_repos_local_service.dart';
import 'starred_repos_remote_service.dart';

class StarredReposRepository {
  final StarredReposRemoteService _remoteService;
  final StarredReposLocalService _localService;

  StarredReposRepository(
    this._remoteService,
    this._localService,
  );

  Future<Either<GithubFailure, Fresh<List<GithubRepo>>>> getStarredReposPage(int page) async {
    try {
      final remotePageItems = await _remoteService.getStarredReposPage(page);

      return right(await remotePageItems.when(
        noConnection: () async {
          return Fresh.no(await _localService.getPage(page).then((data) => data.toDomain()),
              isNextPageAvailable: page < await _localService.getLocalPageCount());
        },
        notModified: (maxPage) async {
          return Fresh.yes(
            await _localService.getPage(page).then((data) => data.toDomain()),
            isNextPageAvailable: page < maxPage,
          );
        },
        withNewData: (data, maxPage) async {
          await _localService.upsertPage(data, page);
          return Fresh.yes(data.toDomain(), isNextPageAvailable: page < maxPage);
        },
      ));
    } on RestApiException catch (e) {
      return left(GithubFailure.api(e.errorCode));
    }
  }
}
