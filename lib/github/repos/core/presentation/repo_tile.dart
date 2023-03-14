import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/routes/app_router.gr.dart';
import '../../../core/domain/github_repo.dart';

class RepoTile extends StatelessWidget {
  final GithubRepo repo;
  const RepoTile({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        AutoRouter.of(context).push(RepoDetailsRoute(repo: repo));
      },
      leading: Hero(
        tag: repo.fullName,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: CachedNetworkImageProvider(repo.owner.avatarUrlSmall),
        ),
      ),
      title: Text(repo.name),
      subtitle: Text(
        repo.description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.star_border),
        Text(
          repo.stargazersCount.toString(),
          style: Theme.of(context).textTheme.bodySmall,
        )
      ]),
    );
  }
}
