import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../infrastructure/github_authenticator.dart';

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
  late WebViewCookieManager _cookieManager;
  var _isLoading = true;

  @override
  void initState() {
    _cookieManager = WebViewCookieManager();

    _cookieManager.clearCookies();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(widget.authorizationUrl)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) {
          setState(() {
            _isLoading = false;
          });
        },
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
      body: SafeArea(
          child:
              _isLoading ? const Center(child: CircularProgressIndicator()) : WebViewWidget(controller: _controller)),
    );
  }
}
