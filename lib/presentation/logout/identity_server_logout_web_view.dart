import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'bloc/logout_bloc.dart';
import 'bloc/logout_event.dart';
import 'bloc/logout_state.dart';

class IdentityServerLogoutWebView extends StatelessWidget {
  const IdentityServerLogoutWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogoutBloc, LogoutState>(
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
                    onNavigationRequest: (NavigationRequest request) async {
                      if (request.url.startsWith(
                        state.redirectUrl.toString(),
                      )) {
                        // Trigger credentials fetch
                        context.read<LogoutBloc>().add(RemoveCredentials());
                        await WebViewCookieManager().clearCookies();
                        return NavigationDecision.prevent;
                      }
                      return NavigationDecision.navigate;
                    },
                  ),
                )
                ..loadRequest(state.logoutUrl);
          return SafeArea(child: WebViewWidget(controller: webViewController));
        }
        return Container();
      },
    );
  }
}
