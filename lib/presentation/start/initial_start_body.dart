import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/home/home_screen.dart';
import 'package:reconstructitapp/presentation/start/start_body.dart';

import 'bloc/initial_bloc.dart';
import 'bloc/initial_state.dart';

/// Redirects to authentication if already started else show starting images
class InitialStartBody extends StatelessWidget {
  const InitialStartBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitialBloc, InitialState>(
      builder: (context, state) {
        if (state is InitialLoaded) {
          if (state.alreadyStarted == true) {
            return AuthenticationHomeScreen();
          } else {
            return StartBody();
          }
        } else {
          return Container();
        }
      },
    );
  }
}
