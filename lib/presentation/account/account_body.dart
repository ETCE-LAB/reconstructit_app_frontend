import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/account/bloc/user_bloc.dart';
import 'package:reconstructitapp/presentation/account/bloc/user_state.dart';

import '../create_or_edit_user/create_or_edit_user_body.dart';

class AccountBody extends StatefulWidget {
  const AccountBody({super.key});

  @override
  State<AccountBody> createState() => _AccountBodyState();
}

class _AccountBodyState extends State<AccountBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading || state is UserInitial) {
          return CircularProgressIndicator();
        } else if (state is UserLoaded) {
          return CreateOrEditUser(
            user: state.user,
            onSubmit: () {},
            buttonText: 'Änderungen speichern',
          );
        } else {
          print(state);
          return Container();
        }
      },
    );
  }
}
