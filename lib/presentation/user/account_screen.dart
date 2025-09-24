import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/create_or_edit_user/create_user_screen.dart';
import 'package:reconstructitapp/presentation/create_or_edit_user/edit_user_screen.dart';

import '../../utils/dependencies.dart';
import 'bloc/user_bloc.dart';
import 'bloc/user_event.dart';
import 'bloc/user_state.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ic<UserBloc>()..add(RefreshUser()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading || state is UserInitial) {
            return Center(child:  CircularProgressIndicator());
          } else if (state is UserLoaded) {
            return EditUserScreen(user: state.user, address: state.address);
          } else if (state is UserNotExisting) {
            return CreateUserScreen();
          }
          return Container();
        },
      ),
    );
  }
}
