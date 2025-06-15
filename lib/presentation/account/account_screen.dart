import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/account/account_body.dart';

import '../../utils/dependencies.dart';
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
    return BlocProvider(
      create: (_) => ic<UserBloc>()..add(Refresh()),
      child: Scaffold(
        appBar: AppBar(title: Text("Nutzerprofil")),
        body: AccountBody(),
      ),
    );
  }
}
