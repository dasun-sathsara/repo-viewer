import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../shared/providers.dart';

class SearchBar extends ConsumerStatefulWidget {
  final Widget body;
  final String title;
  final String hint;
  final void Function(String searchTerm) onShouldNavigateToResultPage;
  final void Function() onSignOutButtonPressed;

  const SearchBar({
    super.key,
    required this.body,
    required this.title,
    required this.hint,
    required this.onShouldNavigateToResultPage,
    required this.onSignOutButtonPressed,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<SearchBar> {
  late FloatingSearchBarController _controller;

  @override
  void initState() {
    super.initState();

    _controller = FloatingSearchBarController();
    ref.read(searchHistoryNotifierProvider.notifier).watchSearchTerms();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void pushPageAndPutFirstInHistory(String searchTerm) {
      widget.onShouldNavigateToResultPage(searchTerm);
      ref.read(searchHistoryNotifierProvider.notifier).putSearchTermFirst(searchTerm);
      _controller.close();
    }

    void pushPageAndAddToHistory(String searchTerm) {
      widget.onShouldNavigateToResultPage(searchTerm);
      ref.read(searchHistoryNotifierProvider.notifier).addSearchTerm(searchTerm);
      _controller.close();
    }

    return FloatingSearchBar(
      height: 58,
      borderRadius: BorderRadius.circular(8),
      controller: _controller,
      implicitDuration: const Duration(milliseconds: 300),
      body: FloatingSearchBarScrollNotifier(child: widget.body),
      hint: widget.hint,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'Tap to search 👆',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      leadingActions: [
        if (AutoRouter.of(context).canPop() && (Platform.isIOS || Platform.isMacOS))
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            splashRadius: 18,
            onPressed: () {
              AutoRouter.of(context).pop();
            },
          )
        else if (AutoRouter.of(context).canPop())
          IconButton(
            icon: const Icon(Icons.arrow_back),
            splashRadius: 18,
            onPressed: () {
              AutoRouter.of(context).pop();
            },
          )
      ],
      actions: [
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
        FloatingSearchBarAction(
          child: IconButton(
            icon: const Icon(MdiIcons.logoutVariant),
            splashRadius: 18,
            onPressed: () {
              widget.onSignOutButtonPressed();
            },
          ),
        )
      ],
      onSubmitted: (query) {
        pushPageAndAddToHistory(query);
      },
      onQueryChanged: (query) {
        ref.read(searchHistoryNotifierProvider.notifier).watchSearchTerms(filter: query);
      },
      automaticallyImplyBackButton: false,
      builder: (context, transition) {
        return Material(
          color: Theme.of(context).cardColor,
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          clipBehavior: Clip.antiAlias,
          child: Consumer(
            builder: (context, ref, child) {
              final searchHistoryState = ref.watch(searchHistoryNotifierProvider);
              return searchHistoryState.map(
                data: (history) {
                  if (_controller.query.isEmpty && history.value.isEmpty) {
                    return Container(
                      height: 58,
                      alignment: Alignment.center,
                      child: Text('Start searching', style: Theme.of(context).textTheme.bodySmall),
                    );
                  } else if (history.value.isEmpty) {
                    return ListTile(
                      title: Text(_controller.query),
                      leading: const Icon(Icons.search),
                      onTap: () {
                        pushPageAndAddToHistory(_controller.query);
                      },
                    );
                  }
                  return Column(
                    children: history.value
                        .map(
                          (term) => ListTile(
                            title: Text(
                              term,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: const Icon(Icons.history),
                            trailing: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                ref.read(searchHistoryNotifierProvider.notifier).deleteSearchTerm(term);
                              },
                            ),
                            onTap: () {
                              pushPageAndPutFirstInHistory(term);
                            },
                          ),
                        )
                        .toList(),
                  );
                },
                loading: (_) => const ListTile(
                  title: LinearProgressIndicator(),
                ),
                error: (_) => const ListTile(
                  title: Text('An unexpected error occured.'),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
