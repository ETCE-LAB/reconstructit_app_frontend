import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/create_or_edit_user/bloc/create_or_edit_user_bloc.dart';
import 'package:reconstructitapp/presentation/create_or_edit_user/create_or_edit_user_body.dart';

import '../../utils/dependencies.dart';
import 'bloc/create_or_edit_user_event.dart';

/// Screen to create a user and address
class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ic<CreateOrEditUserBloc>(),
      child: CreateUserBody(),
    );
  }
}

class CreateUserBody extends StatelessWidget {
  const CreateUserBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Erstelle dein Profil"), centerTitle: true),
      body: CreateOrEditUser(
        buttonText: 'Profil erstellen',
        onCreate: (
          String? profilePicture,
          String fistName,
          String lastName,
          String region,
          String? streetHouseNumber,
          String? zipCode,
          String? city,
          String? country,
        ) {
          context.read<CreateOrEditUserBloc>().add(
            CreateUser(
              profilePicture,
              fistName,
              lastName,
              region,
              streetHouseNumber,
              zipCode,
              city,
              country,
            ),
          );
        },
      ),
    );
  }
}
