import 'package:auto_route/auto_route.dart';

import '../../../auth/presentation/auth_page.dart';
import '../../../auth/presentation/sign_in_page.dart';
import '../../../github/detail/presentation/repo_detail_page.dart';
import '../../../github/repos/searched_repos/presentation/searched_repos_page.dart';
import '../../../github/repos/starred_respos/presentation/starred_repos_page.dart';
import '../../../splash/presentation/splash_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    MaterialRoute(page: SplashPage, initial: true),
    MaterialRoute(page: SignInPage, path: '/sign-in'),
    MaterialRoute(page: GithubAuthPage, path: '/auth'),
    MaterialRoute(page: StarredReposPage, path: '/starred'),
    MaterialRoute(page: SearchedReposPage, path: '/search'),
    MaterialRoute(page: RepoDetailsPage, path: '/detail'),
  ],
)
class $AppRouter {}
