import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/dependencies.dart';
import 'bloc/authentication_bloc.dart';
import 'bloc/authentication_event.dart';
import 'bloc/authentication_state.dart';
import 'identity_server_web_view.dart';

class AuthenticationScreen extends StatefulWidget {
  final VoidCallback? onAuthenticated;

  const AuthenticationScreen({this.onAuthenticated, super.key});

  @override
  State<StatefulWidget> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create:
          (_) => ic<AuthenticationBloc>()..add(PrepareAuthenticationRedirect()),
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSucceeded) {
            Navigator.pop(context);
            if (widget.onAuthenticated != null) {
              widget.onAuthenticated!();
            }
          }
        },
        child: Scaffold(
          body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationIdle) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      CircularProgressIndicator(),
                      Text("Du wirst zur Anmeldung weitergeleitet ..."),
                    ],
                  ),
                );
              } else if (state is RedirectedToIdentityServer) {
                return const IdentityServerWebView();
              } else if (state is FetchingCredentials) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      CircularProgressIndicator(),
                      Text("Anmeldung in Arbeit ..."),
                    ],
                  ),
                );
              } else if (state is AuthenticationFailed) {
                return Center(
                  child: MaterialButton(
                    onPressed: () => _onRetry(context),
                    child: const Text("Erneut versuchen"),
                  ),
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }

  void _onRetry(BuildContext context) {
    context.read<AuthenticationBloc>().add(PrepareAuthenticationRedirect());
  }
}
