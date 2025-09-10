import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/dependencies.dart';
import 'bloc/logout_bloc.dart';
import 'bloc/logout_event.dart';
import 'bloc/logout_state.dart';
import 'identity_server_logout_web_view.dart';

class LogoutScreen extends StatefulWidget {
  final VoidCallback? onLoggedOut;

  const LogoutScreen({super.key, this.onLoggedOut});

  @override
  LogoutScreenState createState() => LogoutScreenState();
}

class LogoutScreenState extends State<LogoutScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LogoutBloc>(
      create:
          (_) =>
      ic<LogoutBloc>()
        ..add(PrepareLogoutRedirect()),
      child: BlocListener<LogoutBloc, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSucceeded) {
            Navigator.pop(context);
            if (widget.onLoggedOut != null) {
              widget.onLoggedOut!();
            }
          }
        },
        child: Scaffold(
          body: BlocBuilder<LogoutBloc, LogoutState>(
            builder: (context, state) {
              if (state is LogoutIdle) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      CircularProgressIndicator(),
                      Text("Du wirst zur Abmeldung weitergeleitet ..."),
                    ],
                  ),
                );
              } else if (state is RedirectedToIdentityServer) {
                return const IdentityServerLogoutWebView();
              } else if (state is RemovingCredentials) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      CircularProgressIndicator(),
                      Text("Abmeldung in Arbeit ..."),
                    ],
                  ),
                );
              } else if (state is LogoutFailed) {
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
    context.read<LogoutBloc>().add(PrepareLogoutRedirect());
  }
}
