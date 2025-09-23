import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/components/app_button.dart';
import 'package:reconstructitapp/domain/entity_models/enums/participant_role.dart';
import 'package:reconstructitapp/presentation/community/community_body_view_model.dart';
import 'package:reconstructitapp/presentation/create_or_edit_request/request_detail_screen.dart';
import 'package:reconstructitapp/presentation/print_contract/bloc/data/print_contract_bloc.dart';
import 'package:reconstructitapp/presentation/print_contract/bloc/interaction/edit_print_contract_bloc.dart';
import 'package:reconstructitapp/presentation/print_contract/bloc/interaction/edit_print_contract_state.dart';
import 'package:reconstructitapp/presentation/print_contract/local_components/custom_stepper.dart';
import 'package:reconstructitapp/presentation/print_contract/local_components/steps/step1.dart';
import 'package:reconstructitapp/presentation/print_contract/local_components/steps/step5.dart';
import 'package:reconstructitapp/presentation/print_contract/print_contract_view_model.dart';
import 'package:reconstructitapp/presentation/request_detail/request_detail_screen.dart';
import 'package:reconstructitapp/presentation/your_requests/your_requests_body_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bloc/data/print_contract_event.dart';
import 'local_components/steps/step2.dart';
import 'local_components/steps/step3.dart';
import 'local_components/steps/step4.dart';
import 'local_components/steps/step6.dart';
import 'local_components/steps/step7.dart';
import 'local_components/steps/step8.dart';

class PrintContractBody extends StatelessWidget {
  final PrintContractViewModel printContractViewModel;

  const PrintContractBody({super.key, required this.printContractViewModel});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditPrintContractBloc, EditPrintContractState>(
      listener: (context, state) {
        if (state is EditPrintContractSucceeded) {
          if (state.cancelled) {
            Navigator.pop(context);
          } else {
            context.read<PrintContractBloc>().add(
              PrintContractRefresh(
                printContractId: printContractViewModel.printContract!.id!,
              ),
            );
          }
        }
      },

      child: Scaffold(
        appBar: AppBar(
          title: InkWell(
            child:
                printContractViewModel.item != null
                    ? Text(printContractViewModel.item!.title)
                    : Container(),
            onTap: () {
              if (printContractViewModel.communityPrintRequest == null ||
                  printContractViewModel.item == null ||
                  printContractViewModel.itemImages == null) {
                return;
              }
              if (printContractViewModel.ownRole ==
                  ParticipantRole.helpProvider) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => CommunityRequestDetailScreen(
                          communityBodyViewModel: CommunityBodyViewModel(
                            printContractViewModel.otherUser,
                            printContractViewModel.communityPrintRequest!,
                            printContractViewModel.item!,
                            printContractViewModel.itemImages,
                          ),
                        ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => RequestDetailScreen(
                          requestsBodyViewModel: YourRequestsBodyViewModel(
                            printContractViewModel.communityPrintRequest!,
                            printContractViewModel.item!,
                            printContractViewModel.itemImages,
                            printContractViewModel.constructionFile,
                          ),
                        ),
                  ),
                );
              }
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 10.0,
            children: [
              // download construction file
              if (printContractViewModel.constructionFile != null)
                AppButton(
                  onPressed: () async {
                    await launchUrl(
                      Uri.parse(
                        printContractViewModel.constructionFile!.fileUrl,
                      ),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.arrow_circle_down),
                      SizedBox(width: 10),
                      Text("Modell Datei herunterladen"),
                    ],
                  ),
                ),
              Divider(),
              OpenAllStepper(
                steps:
                    [
                          Step1(
                            printContractViewModel: printContractViewModel,
                          ).build(context),

                          Step2(
                            printContractViewModel: printContractViewModel,
                          ).build(context),

                          Step3(
                            printContractViewModel: printContractViewModel,
                          ).build(context),

                          Step4(
                            printContractViewModel: printContractViewModel,
                          ).build(context),

                          Step5(
                            printContractViewModel: printContractViewModel,
                          ).build(context),

                          Step6(
                            printContractViewModel: printContractViewModel,
                          ).build(context),
                          Step7(
                            printContractViewModel: printContractViewModel,
                          ).build(context),
                          Step8(
                            printContractViewModel: printContractViewModel,
                          ).build(context),
                        ]
                        // remove nulls
                        .whereType<OpenStep>()
                        .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
