import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingRepoTile extends StatelessWidget {
  const LoadingRepoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 197, 196, 196),
      highlightColor: Colors.grey.shade300,
      child: ListTile(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 14,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        subtitle: Align(
          alignment: Alignment.centerLeft,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                height: 14,
                width: constraints.maxWidth - 15,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            },
          ),
        ),
        leading: const CircleAvatar(),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.star,
            ),
            Text(
              '',
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}
