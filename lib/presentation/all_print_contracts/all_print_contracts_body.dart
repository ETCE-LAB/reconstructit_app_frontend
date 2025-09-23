import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/all_print_contracts/bloc/all_print_contracts_bloc.dart';
import 'package:reconstructitapp/presentation/all_print_contracts/bloc/all_print_contracts_state.dart';
import 'package:reconstructitapp/presentation/all_print_contracts/local_components/print_contract_entry.dart';
import 'package:reconstructitapp/presentation/print_contract/print_contract_screen.dart';

class AllPrintContractsBody extends StatelessWidget {
  const AllPrintContractsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllPrintContractsBloc, AllPrintContractsState>(
      builder: (context, state) {
        if (state is AllPrintContractsLoading ||
            state is AllPrintContractsInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AllPrintContractsLoaded) {
          return state.printContractViewModels.isEmpty
              ? Padding(
                padding: EdgeInsets.all(15),
                child: Text("Ganz schön leer hier..."),
              )
              : Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.separated(
                      itemCount: state.printContractViewModels.length,
                      shrinkWrap: true,

                      itemBuilder:
                          (context, index) => GestureDetector(
                            onTap: () {
                              if (state
                                      .printContractViewModels[index]
                                      .printContract
                                      ?.id !=
                                  null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => PrintContractScreen(
                                          printContractId:
                                              state
                                                  .printContractViewModels[index]
                                                  .printContract!
                                                  .id!,
                                        ),
                                  ),
                                );
                              }
                            },
                            child: PrintContractEntry(
                              printContractViewModel:
                                  state.printContractViewModels[index],
                            ),
                          ),
                      separatorBuilder:
                          (BuildContext context, int index) =>
                              SizedBox(height: 15),
                    ),
                  ],
                ),
              );
        } else {
          return Container();
        }
      },
    );
  }
}
