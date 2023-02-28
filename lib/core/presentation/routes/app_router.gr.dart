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
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../../../auth/presentation/auth_page.dart' as _i3;
import '../../../auth/presentation/sign_in_page.dart' as _i2;
import '../../../github/repos/starred_respos/presentation/starred_repos_page.dart'
    as _i4;
import '../../../splash/presentation/splash_page.dart' as _i1;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    SignInRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.SignInPage(),
      );
    },
    GithubAuthRoute.name: (routeData) {
      final args = routeData.argsAs<GithubAuthRouteArgs>();
      return _i5.MaterialPageX<dynamic>(
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
      return _i5.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.StarredReposPage(),
      );
    },
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i5.RouteConfig(
          SignInRoute.name,
          path: '/sign-in',
        ),
        _i5.RouteConfig(
          GithubAuthRoute.name,
          path: '/auth',
        ),
        _i5.RouteConfig(
          StarredReposRoute.name,
          path: '/starred',
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i5.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.SignInPage]
class SignInRoute extends _i5.PageRouteInfo<void> {
  const SignInRoute()
      : super(
          SignInRoute.name,
          path: '/sign-in',
        );

  static const String name = 'SignInRoute';
}

/// generated route for
/// [_i3.GithubAuthPage]
class GithubAuthRoute extends _i5.PageRouteInfo<GithubAuthRouteArgs> {
  GithubAuthRoute({
    _i6.Key? key,
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

  final _i6.Key? key;

  final void Function(Uri) onAuthorizationCodeRedirectAttempt;

  final Uri authorizationUrl;

  @override
  String toString() {
    return 'GithubAuthRouteArgs{key: $key, onAuthorizationCodeRedirectAttempt: $onAuthorizationCodeRedirectAttempt, authorizationUrl: $authorizationUrl}';
  }
}

/// generated route for
/// [_i4.StarredReposPage]
class StarredReposRoute extends _i5.PageRouteInfo<void> {
  const StarredReposRoute()
      : super(
          StarredReposRoute.name,
          path: '/starred',
        );

  static const String name = 'StarredReposRoute';
}
