import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/all_print_contracts/bloc/print_contract_bloc.dart';
import 'package:reconstructitapp/presentation/all_print_contracts/bloc/print_contract_state.dart';
import 'package:reconstructitapp/presentation/all_print_contracts/local_components/print_contract_entry.dart';
import 'package:reconstructitapp/presentation/print_contract/print_contract_screen.dart';

import '../../components/AppTextField.dart';

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
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              //  AppTextField(hint: "Suche nach Namen oder Titel..."),
                // SizedBox(height: 20),
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
                      (BuildContext context, int index) => SizedBox(height: 15),
                ),
              ],
            ),
          );
        } else {
          print(state);
          return Container();
        }
      },
    );
  }
}
