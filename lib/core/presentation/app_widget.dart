import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repoviewer/auth/shared/providers.dart';
import 'routes/app_router.gr.dart';

final initializationProvider = FutureProvider<void>((ref) async {
  await dotenv.load(fileName: '.env');
  final authNotifer = ref.read(authNotifierProvider.notifier);
  await authNotifer.chechAndUpdateAuthStatus();
});

class AppWidget extends ConsumerWidget {
  AppWidget({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(initializationProvider, (_, __) {});

    ref.listen(authNotifierProvider, (previous, newState) {
      newState.maybeMap(
          orElse: () {},
          authenticated: (_) {
            appRouter.pushAndPopUntil(const StarredReposRoute(), predicate: (route) => false);
          },
          unauthenticated: (_) {
            appRouter.pushAndPopUntil(const SignInRoute(), predicate: (route) => false);
          });
    });

    return MaterialApp.router(
      title: 'Repo Viewer',
      debugShowCheckedModeBanner: false,
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}
