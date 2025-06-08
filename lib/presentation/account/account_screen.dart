import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/account/account_body.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/dependencies.dart';
import '../bloc/authentication_bloc.dart';
import '../bloc/authentication_event.dart';
import '../bloc/authentication_state.dart';
import 'bloc/user_bloc.dart';
import 'bloc/user_event.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) async {
        if (state is AuthenticationSucceeded) {
          if (context.mounted) {
            // refresh user bloc
            //print("Refresh");
            //context.read<ProfileBloc>().add(Refresh());
          }
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is UserSignInRequired) {
            var webViewController =
                WebViewController()
                  ..setJavaScriptMode(JavaScriptMode.unrestricted)
                  ..setNavigationDelegate(
                    NavigationDelegate(
                      onProgress: (int progress) {
                        // update loading bar
                      },
                      onPageStarted: (String url) {},
                      onPageFinished: (String url) {},
                      onHttpError: (HttpResponseError error) {},
                      onWebResourceError: (WebResourceError error) {},
                      onNavigationRequest: (NavigationRequest request) {
                        if (request.url.startsWith(
                          state.redirectUrl.toString(),
                        )) {
                          var responseUrl = Uri.parse(request.url);
                          context.read<AuthenticationBloc>().add(
                            HandleAuthorizationResponse(responseUrl.toString()),
                          );
                          return NavigationDecision.prevent;
                        }
                        return NavigationDecision.navigate;
                      },
                    ),
                  )
                  ..loadRequest(state.authorizationUrl);
            return WebViewWidget(controller: webViewController);
          } else if (state is UserLogoutRequired) {
            print("LOG OUT START");
            print(state.logoutUrl);
            var webViewController =
                WebViewController()
                  ..setJavaScriptMode(JavaScriptMode.unrestricted)
                  ..setNavigationDelegate(
                    NavigationDelegate(
                      onProgress: (int progress) {
                        // update loading bar
                      },
                      onPageStarted: (String url) {},
                      onPageFinished: (String url) {},
                      onHttpError: (HttpResponseError error) {},
                      onWebResourceError: (WebResourceError error) {},
                      onNavigationRequest: (NavigationRequest request) async {
                        print("LOG OUT URI");
                        print(request.url);
                        if (request.url.startsWith(
                          state.redirectUrl.toString(),
                        )) {
                          context.read<AuthenticationBloc>().add(
                            HandleLogoutResponse(),
                          );
                          await WebViewCookieManager().clearCookies();
                          return NavigationDecision.prevent;
                        }
                        return NavigationDecision.navigate;
                      },
                    ),
                  )
                  ..loadRequest(state.logoutUrl);
            return WebViewWidget(controller: webViewController);
          } else if (state is AuthenticationSucceeded) {
            return BlocProvider(
              create: (_) => ic<UserBloc>()..add(Refresh()),
              child: Scaffold(
                appBar: AppBar(title: Text("Nutzerprofil")),
                body: AccountBody(),
              ),
            );
          } else if (state is AuthenticationIdle) {
            return Scaffold(body: Text("lade authentication"));
          } else if (state is AuthenticationFailed) {
            return Scaffold(body: Text("fehler in authentication"));
          } else {
            print(state);
            return Container();
          }
        },
      ),
    );
  }
}
