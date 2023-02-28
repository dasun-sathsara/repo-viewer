import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/domain/github_repo.dart';

class RepoTile extends StatelessWidget {
  final GithubRepo repo;
  const RepoTile({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        //Todo: Navigate to details page
      },
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: CachedNetworkImageProvider(repo.owner.avatarUrlSmall),
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
