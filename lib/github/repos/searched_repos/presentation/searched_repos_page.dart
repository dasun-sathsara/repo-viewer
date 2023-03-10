import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../auth/shared/providers.dart';
import '../../../../core/presentation/routes/app_router.gr.dart';
import '../../../../search/presentation/search_bar.dart';
import '../../../core/shared/providers.dart';
import '../../core/presentation/paginated_repos_list_view.dart';

class SearchedReposPage extends ConsumerStatefulWidget {
  final String query;
  const SearchedReposPage(this.query, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchedReposPageState();
}

class _SearchedReposPageState extends ConsumerState<SearchedReposPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(searchedReposNotifierProvider.notifier).getFirstSearchedReposPage(widget.query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SearchBar(
      title: widget.query,
      hint: 'Search all repositories...',
      onShouldNavigateToResultPage: (query) {
        AutoRouter.of(context).pushAndPopUntil(
          SearchedReposRoute(query: query),
          predicate: (route) => route.settings.name == StarredReposRoute.name,
        );
      },
      onSignOutButtonPressed: () {
        ref.read(authNotifierProvider.notifier).signOut();
      },
      body: PaginatedReposListView(searchedReposNotifierProvider, (ref) {
        ref.read(searchedReposNotifierProvider.notifier).getNextSearchedReposPage(widget.query);
      }, 'No results were found for the search query.',
          'An active internet conection is required for the search feature to work'),
    ));
  }
}
