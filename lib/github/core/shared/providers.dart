import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/shared/providers.dart';
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

final starredReposNotifierProvider = StateNotifierProvider<StarredReposNotifier, StarredReposState>(
  (ref) => StarredReposNotifier(
    ref.watch(starredReposRepositoryProvider),
  ),
);
