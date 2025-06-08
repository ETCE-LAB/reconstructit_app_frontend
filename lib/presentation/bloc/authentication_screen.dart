import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication_bloc.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  AuthenticationScreenState createState() => AuthenticationScreenState();
}

class AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  void initState() {
    super.initState();
    // Start authentication process when launching the screen
    _onRetry();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        // Exit the authentication screen if user is authenticated
        print("State in Authentication screen");
        if (state is AuthenticationSucceeded) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: Center(
          child: MaterialButton(
              onPressed: _onRetry, child: const Text("Erneut versuchen")),
        ),
      ),
    );
  }

  void _onRetry() {
    context.read<AuthenticationBloc>().add(Authenticate());
  }
}
