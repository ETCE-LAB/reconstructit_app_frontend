import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/all_print_contracts/all_print_contracts_body.dart';
import 'package:reconstructitapp/presentation/all_print_contracts/bloc/print_contract_event.dart';

import '../../utils/dependencies.dart';
import 'bloc/print_contract_bloc.dart';

class AllPrintContractsScreen extends StatefulWidget {
  const AllPrintContractsScreen({super.key});

  @override
  State<AllPrintContractsScreen> createState() =>
      _AllPrintContractsScreenState();
}

class _AllPrintContractsScreenState extends State<AllPrintContractsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => ic<AllPrintContractsBloc>()..add(AllPrintContractsRefresh()),
      child: Scaffold(
        appBar: AppBar(title: Text("Vorgänge"), centerTitle: true,),
        body: AllPrintContractsBody(),
      ),
    );
  }
}
