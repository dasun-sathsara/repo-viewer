import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repoviewer/github/repos/starred_respos/application/starred_repos_notifier.dart';
import 'package:repoviewer/github/repos/starred_respos/presentation/failure_repo_tile.dart';
import '../../../core/shared/providers.dart';
import 'repo_tile.dart';

import 'loading_repo_tile.dart';

class PaginatedReposListView extends ConsumerStatefulWidget {
  const PaginatedReposListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaginatedReposListViewState();
}

class _PaginatedReposListViewState extends ConsumerState<PaginatedReposListView> {
  var canLoadNextPage = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(starredReposNotifierProvider);
    ref.listen(starredReposNotifierProvider, (_, newState) {
      newState.map(
        initial: (value) {
          canLoadNextPage = true;
        },
        loadInProgress: (value) {
          canLoadNextPage = false;
        },
        loadSuccess: (value) {
          canLoadNextPage = value.isNextPageAvailable;
        },
        loadFailure: (value) {

          canLoadNextPage = false;
        },
      );
    });

    return NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          final metrics = notification.metrics;
          final limit = metrics.maxScrollExtent - (metrics.viewportDimension / 3);

          if (canLoadNextPage && metrics.pixels >= limit) {
            canLoadNextPage = false;
            ref.read(starredReposNotifierProvider.notifier).getNextStarredReposPage();
          }
          return false;
        },
        child: _PaginatedListView(state: state));
  }
}

class _PaginatedListView extends StatelessWidget {
  const _PaginatedListView({
    required this.state,
  });

  final StarredReposState state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.map(
        initial: (value) => value.repos.entity.length,
        loadInProgress: (value) => value.repos.entity.length + value.itemsPerPage,
        loadSuccess: (value) => value.repos.entity.length,
        loadFailure: (value) => value.repos.entity.length + 1,
      ),
      itemBuilder: (context, index) {
        return state.map(
          initial: (value) {
            return RepoTile(repo: state.repos.entity[index]);
          },
          loadInProgress: (value) {
            if (index < value.repos.entity.length) {
              return RepoTile(repo: value.repos.entity[index]);
            } else {
              return const LoadingRepoTile();
            }
          },
          loadSuccess: (value) {
            return RepoTile(repo: value.repos.entity[index]);
          },
          loadFailure: (value) {
            if (index < value.repos.entity.length) {
              return RepoTile(repo: value.repos.entity[index]);
            } else {
              return FailureRepoTile(failure: value.failure);
            }
          },
        );
      },
    );
  }
}
