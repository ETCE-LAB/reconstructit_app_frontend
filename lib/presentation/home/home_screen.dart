import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/account/account_screen.dart';
import 'package:reconstructitapp/presentation/chat/chat_screen.dart';
import 'package:reconstructitapp/presentation/community/community_screen.dart';
import 'package:reconstructitapp/presentation/your_requests/your_requests_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../bloc/authentication_bloc.dart';
import '../bloc/authentication_event.dart';
import '../bloc/authentication_state.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_event.dart';
import 'bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    context.read<AuthenticationBloc>().add(Authenticate());
  }

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
            return BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeIdle) {
                  return Scaffold(
                    bottomNavigationBar: NavigationBar(
                        surfaceTintColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        selectedIndex: state.selectedPage,
                        onDestinationSelected: _onPageChanged,
                        destinations: [
                          NavigationDestination(
                              selectedIcon: Icon(
                                Icons.handyman_outlined,
                                // color: context.primary,
                              ),
                              icon: Icon(
                                Icons.handyman_outlined,
                                // color: context.lightPrimary,
                              ),
                              label: "Helfen"),
                          NavigationDestination(
                              selectedIcon: Icon(
                                Icons.groups_outlined,
                                // color: context.primary,
                              ),
                              icon: Icon(
                                Icons.groups_outlined,
                                //  color: context.lightPrimary,
                              ),
                              label: "Reparatur"),
                          NavigationDestination(
                              selectedIcon:
                              Icon(Icons.chat_outlined,
                                //  color: context.primary
                              ),

                              icon: Icon(Icons.chat_outlined,
                                //color: context.lightPrimary
                              ),

                              label: "Profil"),
                          NavigationDestination(
                              selectedIcon:
                              Icon(Icons.account_circle_outlined,
                                //  color: context.primary
                              ),
                              icon: Icon(Icons.account_circle_outlined,
                                //  color: context.lightPrimary
                              ),
                              label: "Profil"),
                        ]),
                    body: SafeArea(
                      child: const [
                        YourRequestsScreen(),
                        CommunityScreen(),
                        ChatScreen(),
                        AccountScreen()
                      ][state.selectedPage],
                    ),
                  );
                } else {
                  // TODO: add splashscreen here
                  return Container();
                }
              },
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

  void _onPageChanged(int index) {
    context.read<HomeBloc>().add(HomePageChanged(index));
  }
  }

