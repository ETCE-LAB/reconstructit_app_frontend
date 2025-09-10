import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/print_contract/bloc/interaction/edit_print_contract_bloc.dart';
import 'package:reconstructitapp/presentation/print_contract/print_contract_body.dart';

import '../../utils/dependencies.dart';
import 'bloc/data/print_contract_bloc.dart';
import 'bloc/data/print_contract_event.dart';
import 'bloc/data/print_contract_state.dart';

class PrintContractScreen extends StatefulWidget {
  final String printContractId;

  const PrintContractScreen({super.key, required this.printContractId});

  @override
  State<PrintContractScreen> createState() => _PrintContractScreenState();
}

class _PrintContractScreenState extends State<PrintContractScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  ic<PrintContractBloc>()..add(
                    PrintContractRefresh(
                      printContractId: widget.printContractId,
                    ),
                  ),
        ),
        BlocProvider(create: (_) => ic<EditPrintContractBloc>()),
      ],
      child: BlocBuilder<PrintContractBloc, PrintContractState>(
        builder: (context, state) {
          if (state is PrintContractInitial) {
            return CircularProgressIndicator();
          } else if (state is PrintContractLoaded) {
            return PrintContractBody(
              printContractViewModel: state.printContractViewModel,
            );
          } else if (state is PrintContractFailed) {
            return Text("FEHLER");
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
