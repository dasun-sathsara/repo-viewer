import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../../../../core/presentation/toasts.dart';
import '../../../core/presentation/no_results_page.dart';
import '../application/repos_notifier.dart';
import 'failure_repo_tile.dart';
import 'loading_repo_tile.dart';
import 'repo_tile.dart';

class PaginatedReposListView extends ConsumerStatefulWidget {
  final AutoDisposeStateNotifierProvider<ReposNotifier, ReposState> reposNotifierProvider;
  final String noNetowrkMessage;
  final void Function(WidgetRef ref) getNextPage;
  final String noResultMessage;

  const PaginatedReposListView(
      this.reposNotifierProvider, this.getNextPage, this.noResultMessage, this.noNetowrkMessage,
      {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaginatedReposListViewState();
}

class _PaginatedReposListViewState extends ConsumerState<PaginatedReposListView> {
  var canLoadNextPage = false;
  var hasShownToast = false;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.reposNotifierProvider);
    ref.listen(widget.reposNotifierProvider, (_, newState) {
      newState.map(
        initial: (value) {
          canLoadNextPage = true;
        },
        loadInProgress: (value) {
          canLoadNextPage = false;
        },
        loadSuccess: (value) {
          if (!value.repos.isFresh && !hasShownToast) {
            showNoConnectionToast(widget.noNetowrkMessage, context);
            hasShownToast = true;
          }
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
            widget.getNextPage(ref);
          }
          return false;
        },
        child: state.maybeMap(orElse: () => false, loadSuccess: (value) => state.repos.entity.isEmpty)
            ? NoResultsDisplay(
                message: widget.noResultMessage,
              )
            : _PaginatedListView(state: state));
  }
}

class _PaginatedListView extends StatelessWidget {
  const _PaginatedListView({
    required this.state,
  });

  final ReposState state;

  @override
  Widget build(BuildContext context) {
    final fsb = FloatingSearchBar.of(context)?.widget;

    return ListView.builder(
      padding:
          fsb == null ? EdgeInsets.zero : EdgeInsets.only(top: fsb.height + 8 + MediaQuery.of(context).padding.top),
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
