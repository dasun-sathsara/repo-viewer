import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../core/presentation/toasts.dart';
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
    Future.microtask(() => ref.read(searchedReposNotifierProvider.notifier).getNextSearchedReposPage(widget.query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.query),
          actions: [
            IconButton(
                onPressed: () {
                  showNoConnectionToast(
                    "You're not online. Some information may be outdated.",
                    context,
                  );
                  // ref.read(authNotifierProvider.notifier).signOut();
                },
                icon: const Icon(MdiIcons.logoutVariant))
          ],
        ),
        body: PaginatedReposListView(searchedReposNotifierProvider, (ref) {
          ref.read(searchedReposNotifierProvider.notifier).getNextSearchedReposPage(widget.query);
        }, 'No results were found for the search query.',
            'An active internet conection is required for the search feature to work'));
  }
}
