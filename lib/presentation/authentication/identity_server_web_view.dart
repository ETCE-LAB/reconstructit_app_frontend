import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'bloc/authentication_bloc.dart';
import 'bloc/authentication_event.dart';
import 'bloc/authentication_state.dart';

class IdentityServerWebView extends StatelessWidget {
  const IdentityServerWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (prev, curr) => curr is RedirectedToIdentityServer,
      builder: (context, state) {
        if (state is RedirectedToIdentityServer) {
          var webViewController =
          WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setNavigationDelegate(
              NavigationDelegate(
                onProgress: (int progress) {},
                onPageStarted: (String url) {},
                onPageFinished: (String url) {},
                onHttpError: (HttpResponseError error) {},
                onWebResourceError: (WebResourceError error) {},
                onNavigationRequest: (NavigationRequest request) {
                  if (request.url.startsWith(
                    state.redirectUrl.toString(),
                  )) {
                    // Parse response url
                    var responseUrl = Uri.parse(request.url);
                    // Trigger credentials fetch
                    context.read<AuthenticationBloc>().add(
                      FetchCredentials(state.currentGrant, responseUrl),
                    );
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              ),
            )
            ..loadRequest(state.authorizationUrl);
          return SafeArea(child: WebViewWidget(controller: webViewController));
        }
        return Container();
      },
    );
  }
}
