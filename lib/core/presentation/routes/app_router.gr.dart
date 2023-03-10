// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../../../auth/presentation/auth_page.dart' as _i3;
import '../../../auth/presentation/sign_in_page.dart' as _i2;
import '../../../github/core/domain/github_repo.dart' as _i9;
import '../../../github/detail/presentation/repo_detail_page.dart' as _i6;
import '../../../github/repos/searched_repos/presentation/searched_repos_page.dart'
    as _i5;
import '../../../github/repos/starred_respos/presentation/starred_repos_page.dart'
    as _i4;
import '../../../splash/presentation/splash_page.dart' as _i1;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.SignInPage(),
      );
    },
    GithubAuthRoute.name: (routeData) {
      final args = routeData.argsAs<GithubAuthRouteArgs>();
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.GithubAuthPage(
          key: args.key,
          onAuthorizationCodeRedirectAttempt:
              args.onAuthorizationCodeRedirectAttempt,
          authorizationUrl: args.authorizationUrl,
        ),
      );
    },
    StarredReposRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.StarredReposPage(),
      );
    },
    SearchedReposRoute.name: (routeData) {
      final args = routeData.argsAs<SearchedReposRouteArgs>();
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.SearchedReposPage(
          args.query,
          key: args.key,
        ),
      );
    },
    RepoDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<RepoDetailsRouteArgs>();
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.RepoDetailsPage(
          args.repo,
          key: args.key,
        ),
      );
    },
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i7.RouteConfig(
          SignInRoute.name,
          path: '/sign-in',
        ),
        _i7.RouteConfig(
          GithubAuthRoute.name,
          path: '/auth',
        ),
        _i7.RouteConfig(
          StarredReposRoute.name,
          path: '/starred',
        ),
        _i7.RouteConfig(
          SearchedReposRoute.name,
          path: '/search',
        ),
        _i7.RouteConfig(
          RepoDetailsRoute.name,
          path: '/detail',
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.SignInPage]
class SignInRoute extends _i7.PageRouteInfo<void> {
  const SignInRoute()
      : super(
          SignInRoute.name,
          path: '/sign-in',
        );

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i3.GithubAuthPage]
class GithubAuthRoute extends _i7.PageRouteInfo<GithubAuthRouteArgs> {
  GithubAuthRoute({
    _i8.Key? key,
    required void Function(Uri) onAuthorizationCodeRedirectAttempt,
    required Uri authorizationUrl,
  }) : super(
          GithubAuthRoute.name,
          path: '/auth',
          args: GithubAuthRouteArgs(
            key: key,
            onAuthorizationCodeRedirectAttempt:
                onAuthorizationCodeRedirectAttempt,
            authorizationUrl: authorizationUrl,
          ),
        );

  static const String name = 'GithubAuthRoute';
}

class GithubAuthRouteArgs {
  const GithubAuthRouteArgs({
    this.key,
    required this.onAuthorizationCodeRedirectAttempt,
    required this.authorizationUrl,
  });

  final _i8.Key? key;

  final void Function(Uri) onAuthorizationCodeRedirectAttempt;

  final Uri authorizationUrl;

  @override
  String toString() {
    return 'GithubAuthRouteArgs{key: $key, onAuthorizationCodeRedirectAttempt: $onAuthorizationCodeRedirectAttempt, authorizationUrl: $authorizationUrl}';
  }
}

/// generated route for
/// [_i4.StarredReposPage]
class StarredReposRoute extends _i7.PageRouteInfo<void> {
  const StarredReposRoute()
      : super(
          StarredReposRoute.name,
          path: '/starred',
        );

  static const String name = 'StarredReposRoute';
}

/// generated route for
/// [_i5.SearchedReposPage]
class SearchedReposRoute extends _i7.PageRouteInfo<SearchedReposRouteArgs> {
  SearchedReposRoute({
    required String query,
    _i8.Key? key,
  }) : super(
          SearchedReposRoute.name,
          path: '/search',
          args: SearchedReposRouteArgs(
            query: query,
            key: key,
          ),
        );

  static const String name = 'SearchedReposRoute';
}

class SearchedReposRouteArgs {
  const SearchedReposRouteArgs({
    required this.query,
    this.key,
  });

  final String query;

  final _i8.Key? key;

  @override
  String toString() {
    return 'SearchedReposRouteArgs{query: $query, key: $key}';
  }
}

/// generated route for
/// [_i6.RepoDetailsPage]
class RepoDetailsRoute extends _i7.PageRouteInfo<RepoDetailsRouteArgs> {
  RepoDetailsRoute({
    required _i9.GithubRepo repo,
    _i8.Key? key,
  }) : super(
          RepoDetailsRoute.name,
          path: '/detail',
          args: RepoDetailsRouteArgs(
            repo: repo,
            key: key,
          ),
        );

  static const String name = 'RepoDetailsRoute';
}

class RepoDetailsRouteArgs {
  const RepoDetailsRouteArgs({
    required this.repo,
    this.key,
  });

  final _i9.GithubRepo repo;

  final _i8.Key? key;

  @override
  String toString() {
    return 'RepoDetailsRouteArgs{repo: $repo, key: $key}';
  }
}
