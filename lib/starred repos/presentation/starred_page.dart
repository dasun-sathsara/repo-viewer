import 'package:flutter/material.dart';

class StarredReposPage extends StatelessWidget {
  const StarredReposPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        'Starred Repos Page',
        style: TextStyle(fontSize: 20),
      )),
    );
  }
}
