import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/create_or_edit_request/bloc/create_or_edit_request_bloc.dart';
import 'package:reconstructitapp/presentation/create_or_edit_request/bloc/create_or_edit_request_event.dart';
import 'package:reconstructitapp/presentation/create_or_edit_request/bloc/create_or_edit_request_state.dart';

import '../../domain/entity_models/enums/print_material.dart';
import '../../utils/dependencies.dart';
import '../../utils/presenter.dart';
import '../your_items/your_items_body_view_model.dart';
import 'create_or_edit_request_body.dart';

/// Screen to show an own community print request
/// Screen to edit the community print request
class OwnRequestDetailScreen extends StatefulWidget {
  final YourItemsBodyViewModel requestsBodyViewModel;

  const OwnRequestDetailScreen({
    super.key,
    required this.requestsBodyViewModel,
  });

  @override
  State<OwnRequestDetailScreen> createState() => _OwnRequestDetailScreenState();
}

class _OwnRequestDetailScreenState extends State<OwnRequestDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ic<CreateOrEditRequestBloc>(),
      child: YourRequestDetailBody(
        requestsBodyViewModel: widget.requestsBodyViewModel,
      ),
    );
  }
}

class YourRequestDetailBody extends StatelessWidget {
  final YourItemsBodyViewModel requestsBodyViewModel;

  const YourRequestDetailBody({super.key, required this.requestsBodyViewModel});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateOrEditRequestBloc, CreateOrEditRequestState>(
      listener: (context, state) {
        if (state is CreateOrEditRequestSucceeded) {
          Presenter().presentSuccess(context, "Erfolg");
          Navigator.pop(context);
        } else if (state is CreateOrEditRequestFailed) {
          Presenter().presentFailure(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(requestsBodyViewModel.item.title)),
        body: CreateOrEditRequestBody(
          requestsBodyViewModel: requestsBodyViewModel,
          onSubmitEdit: (
              YourItemsBodyViewModel yourRequestsBodyViewModel,
            String title,
            String description,
            bool repaired,
            List<String> images,
            PrintMaterial? printMaterial,
            bool withRequest,
          ) {
            context.read<CreateOrEditRequestBloc>().add(
              EditRequest(
                title,
                description,
                repaired,
                images,
                printMaterial,
                withRequest,
                yourRequestsBodyViewModel,
              ),
            );
          },
        ),
      ),
    );
  }
}
