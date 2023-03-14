import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../detail/infrastructure/repo_detail_local_service.dart';
import '../../detail/infrastructure/repo_detail_repository.dart';

import '../../../core/shared/providers.dart';
import '../../detail/application/repo_detail_notifier.dart';
import '../../detail/infrastructure/repo_detail_remote_service.dart';
import '../../repos/core/application/repos_notifier.dart';
import '../../repos/searched_repos/application/searched_repos_notifier.dart';
import '../../repos/searched_repos/infrastructure/searched_repos_remote_service.dart';
import '../../repos/searched_repos/infrastructure/searched_repos_repository.dart';
import '../../repos/starred_respos/application/starred_repos_notifier.dart';
import '../../repos/starred_respos/infrastructure/starred_repos_local_service.dart';
import '../../repos/starred_respos/infrastructure/starred_repos_remote_service.dart';
import '../../repos/starred_respos/infrastructure/starred_repos_repository.dart';
import '../infrastructure/github_headers_cache.dart';

final githubHeadersCacheProvider = Provider(
  (ref) => GithubHeadersCache(
    ref.watch(sembastProvider),
  ),
);

final starredReposLocalServiceProvider = Provider(
  (ref) => StarredReposLocalService(
    ref.watch(sembastProvider),
  ),
);

final starredReposRemoteServiceProvider = Provider(
  (ref) => StarredReposRemoteService(
    ref.watch(dioProvider),
    ref.watch(githubHeadersCacheProvider),
  ),
);

final starredReposRepositoryProvider = Provider(
  (ref) => StarredReposRepository(
    ref.watch(starredReposRemoteServiceProvider),
    ref.watch(starredReposLocalServiceProvider),
  ),
);

final starredReposNotifierProvider = StateNotifierProvider.autoDispose<StarredReposNotifier, ReposState>(
  (ref) => StarredReposNotifier(
    ref.watch(starredReposRepositoryProvider),
  ),
);

final searchedReposRemoteServiceProvider = Provider((ref) {
  return SearchedReposRemoteService(ref.watch(dioProvider), ref.watch(githubHeadersCacheProvider));
});

final searchedReposRepositoryProvider = Provider((ref) {
  return SearchedRemoteRepository(ref.watch(searchedReposRemoteServiceProvider));
});

final searchedReposNotifierProvider = StateNotifierProvider.autoDispose<SearchedReposNotifier, ReposState>((ref) {
  return SearchedReposNotifier(ref.watch(searchedReposRepositoryProvider));
});

final repoDetailLocalServiceProvider = Provider((ref) => RepoDetailLocalService(
      ref.watch(sembastProvider),
      ref.watch(githubHeadersCacheProvider),
    ));

final repoDetailRemoteServiceProvider = Provider((ref) => RepoDetailRemoteService(
      ref.watch(dioProvider),
      ref.watch(githubHeadersCacheProvider),
    ));

final repoDetailRepositoryProvider = Provider((ref) => RepoDetailRepository(
      ref.watch(repoDetailLocalServiceProvider),
      ref.watch(repoDetailRemoteServiceProvider),
    ));

final repoDetailNotifierProvider = StateNotifierProvider.autoDispose<RepoDetailNotifier, RepoDetailState>(
  (ref) => RepoDetailNotifier(
    ref.watch(repoDetailRepositoryProvider),
  ),
);
