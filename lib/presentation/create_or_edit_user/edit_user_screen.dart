import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/create_or_edit_user/bloc/create_or_edit_user_event.dart';

import '../../domain/entity_models/address.dart';
import '../../domain/entity_models/user.dart';
import '../../utils/dependencies.dart';
import 'bloc/create_or_edit_user_bloc.dart';
import 'create_or_edit_user_body.dart';

/// Screen to edit user and address
class EditUserScreen extends StatefulWidget {
  final Address? address;
  final User user;

  const EditUserScreen({super.key, this.address, required this.user});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ic<CreateOrEditUserBloc>(),
      child: EditUserBody(user: widget.user, address: widget.address),
    );
  }
}

class EditUserBody extends StatelessWidget {
  final User user;
  final Address? address;

  const EditUserBody({super.key, required this.user, this.address});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nutzerprofil"), centerTitle: true,),
      body: CreateOrEditUser(
        user: user,
        address: address,
        buttonText: 'Änderungen speichern',

        onEdit: (
          User oldUser,
          Address? oldAddress,
          String? profilePicture,
          String fistName,
          String lastName,
          String region,
          String? streetHouseNumber,
          String? zipCode,
          String? city,
            String? country
        ) {
          context.read<CreateOrEditUserBloc>().add(
            EditUser(
              oldUser,
              oldAddress,
              profilePicture,
              fistName,
              lastName,
              region,
              streetHouseNumber,
              zipCode,
              city,country
            ),
          );
        },
      ),
    );
  }
}
