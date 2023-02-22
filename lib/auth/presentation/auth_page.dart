import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../infrastructure/github_authenticator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GithubAuthPage extends ConsumerStatefulWidget {
  final Uri authorizationUrl;
  final void Function(Uri redirectUrl) onAuthorizationCodeRedirectAttempt;

  const GithubAuthPage({
    super.key,
    required this.onAuthorizationCodeRedirectAttempt,
    required this.authorizationUrl,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GithubAuthPageState();
}

class _GithubAuthPageState extends ConsumerState<GithubAuthPage> {
  late WebViewController _controller;

  @override
  void initState() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(widget.authorizationUrl)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) {
          if (request.url.startsWith(GithubAuthenticator.redirectUrl.toString())) {
            widget.onAuthorizationCodeRedirectAttempt(Uri.parse(request.url));
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ))
      ..clearCache()
      ..clearLocalStorage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: _controller)),
    );
  }
}
