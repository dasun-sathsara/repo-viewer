import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repoviewer/auth/shared/providers.dart';

class StarredReposPage extends ConsumerWidget {
  const StarredReposPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Starred Repos Page',
            style: TextStyle(fontSize: 20),
          ),
          IconButton(
              onPressed: () {
                ref.read(authNotifierProvider.notifier).signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      )),
    );
  }
}
