import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:repoviewer/github/core/domain/github_repo.dart';
import 'package:repoviewer/github/core/shared/providers.dart';
import 'package:shimmer/shimmer.dart';

class RepoDetailsPage extends ConsumerStatefulWidget {
  final GithubRepo repo;
  const RepoDetailsPage(this.repo, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RepoDetailPageState();
}

class _RepoDetailPageState extends ConsumerState<RepoDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(repoDetailNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Hero(
              tag: widget.repo.fullName,
              child: CircleAvatar(
                radius: 16,
                backgroundImage: CachedNetworkImageProvider(widget.repo.owner.avatarUrlSmall),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              widget.repo.name,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
        actions: [
          state.maybeMap(
            orElse: () => Shimmer.fromColors(
              baseColor: Colors.grey.shade400,
              highlightColor: Colors.grey.shade300,
              child: IconButton(
                icon: const Icon(Icons.star),
                onPressed: null,
                disabledColor: Theme.of(context).iconTheme.color,
              ),
            ),
            loadSuccess: (state) => IconButton(
              icon: Icon(
                !state.repoDetail.isFresh
                    ? MdiIcons.starRemoveOutline
                    : state.repoDetail.entity?.starred == true
                        ? Icons.star
                        : Icons.star_outline,
              ),
              onPressed: !state.repoDetail.isFresh
                  ? null
                  : () {
                      ref.read(repoDetailNotifierProvider.notifier).switchStarredStatus(state.repoDetail.entity!);
                    },
            ),
          ),
        ],
      ),
    );
  }
}
