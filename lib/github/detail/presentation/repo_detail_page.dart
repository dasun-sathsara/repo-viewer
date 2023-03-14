import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:repoviewer/core/presentation/toasts.dart';
import 'package:repoviewer/github/core/domain/github_repo.dart';
import 'package:repoviewer/github/core/presentation/no_results_page.dart';
import 'package:repoviewer/github/core/shared/providers.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class RepoDetailsPage extends ConsumerStatefulWidget {
  final GithubRepo repo;
  const RepoDetailsPage(this.repo, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RepoDetailPageState();
}

class _RepoDetailPageState extends ConsumerState<RepoDetailsPage> {
  late String css;

  @override
  void initState() {
    super.initState();

    DefaultAssetBundle.of(context).loadString('assets/css/styles.css').then((cssString) => css = cssString);

    Future.microtask(() {
      ref.watch(repoDetailNotifierProvider.notifier).getRepoDetail(widget.repo.fullName);
    });
  }

  WebViewController htmlController(String html) {
    return WebViewController()
      ..loadHtmlString(html)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) {
          url_launcher.launchUrl(Uri.parse(request.url));
          return NavigationDecision.prevent;
        },
      ));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(repoDetailNotifierProvider);

    ref.listen(repoDetailNotifierProvider, (_, state) {
      state.maybeMap(
        orElse: () {},
        loadSuccess: (success) {
          if (!success.repoDetail.isFresh) {
            showNoConnectionToast('You\'re not online. Some information may be outdated.', context);
          }
        },
      );
    });

    return WillPopScope(
      onWillPop: () async {
        if (state.hasStarredStatusChanged) {
          ref.read(starredReposNotifierProvider.notifier).getFirstStarredReposPage();
        }
        return true;
      },
      child: Scaffold(
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
        body: state.map(
          initial: (_) => Container(),
          loadInProgress: (_) => const Center(
            child: CircularProgressIndicator(),
          ),
          loadSuccess: (_) {
            if (_.repoDetail.entity == null) {
              return const Center(child: NoResultsDisplay(message: 'This is all we could find.'));
            } else {
              final html = '''
                <!DOCTYPE html>
                <html lang="en">
                <head>
                    <meta charset="UTF-8">
                    <meta http-equiv="X-UA-Compatible" content="IE=edge">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Document</title>
                </head>
                <body>
                    ${_.repoDetail.entity!.html}
                </body>
                </html>

                <style>
                  $css
                </style>
                ''';
              return WebViewWidget(
                controller: htmlController(html),
              );
            }
          },
          loadFailure: (_) => Center(
            child: Text(_.failure.toString()),
          ),
        ),
      ),
    );
  }
}
