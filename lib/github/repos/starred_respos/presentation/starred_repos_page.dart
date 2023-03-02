import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:repoviewer/core/presentation/routes/app_router.gr.dart';

import '../../../../core/presentation/toasts.dart';
import '../../../core/shared/providers.dart';
import '../../core/presentation/paginated_repos_list_view.dart';

class StarredReposPage extends ConsumerStatefulWidget {
  const StarredReposPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StarredReposPageState();
}

class _StarredReposPageState extends ConsumerState<StarredReposPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(starredReposNotifierProvider.notifier).getNextStarredReposPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Starred Repos'),
        actions: [
          IconButton(
              onPressed: () {
                showNoConnectionToast(
                  "You're not online. Some information may be outdated.",
                  context,
                );
                // ref.read(authNotifierProvider.notifier).signOut();
              },
              icon: const Icon(MdiIcons.logoutVariant)),
          IconButton(
              onPressed: () {
                AutoRouter.of(context).push(SearchedReposRoute(query: 'react'));
              },
              icon: const Icon(MdiIcons.magnify))
        ],
      ),
      body: PaginatedReposListView(
          starredReposNotifierProvider,
          (ref) => ref.read(starredReposNotifierProvider.notifier).getNextStarredReposPage(),
          'User does not have any starred repositories',
          'You are not online. Some information might be outdated.'),
    );
  }
}
