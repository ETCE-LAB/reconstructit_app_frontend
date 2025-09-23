import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/create_or_edit_request/create_or_edit_request_body.dart';

import '../../../domain/entity_models/enums/print_material.dart';
import '../../../utils/dependencies.dart';
import '../bloc/create_or_edit_request_bloc.dart';
import '../bloc/create_or_edit_request_event.dart';
import '../bloc/create_or_edit_request_state.dart';

class CreateRequestScreen extends StatefulWidget {
  const CreateRequestScreen({super.key});

  @override
  State<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ic<CreateOrEditRequestBloc>(),
      child: Scaffold(appBar: AppBar(), body: CreateRequestBody()),
    );
  }
}

class CreateRequestBody extends StatelessWidget {
  const CreateRequestBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateOrEditRequestBloc, CreateOrEditRequestState>(
      listener: (context, state) {
        if (state is CreateOrEditRequestSucceeded) {
          Navigator.pop(context);
        }
      },
      child: CreateOrEditRequestBody(
        requestsBodyViewModel: null,
        onSubmitCreate: (
          List<String> images,
          String title,
          String description,

          PrintMaterial? printMaterial,
          String modelFilePath,
        ) {
          context.read<CreateOrEditRequestBloc>().add(
            CreateRequest(
              images,
              title,
              description,
              printMaterial,
              modelFilePath,
            ),
          );
        },
      ),
    );
  }
}
