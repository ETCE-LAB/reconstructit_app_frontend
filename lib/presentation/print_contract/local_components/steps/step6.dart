import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/components/app_shimmer_rectangular.dart';
import 'package:reconstructitapp/domain/entity_models/enums/participant_role.dart';
import 'package:reconstructitapp/domain/entity_models/enums/print_contract_status.dart';
import 'package:reconstructitapp/presentation/print_contract/bloc/interaction/edit_print_contract_event.dart';
import 'package:reconstructitapp/presentation/print_contract/local_components/custom_stepper.dart';
import 'package:reconstructitapp/presentation/print_contract/print_contract_view_model.dart';

import '../../../../components/app_button.dart';
import '../../../../domain/entity_models/enums/payment_status.dart';
import '../../bloc/interaction/edit_print_contract_bloc.dart';

class Step6 {
  final PrintContractViewModel printContractViewModel;

  const Step6({required this.printContractViewModel});

  OpenStep? build(BuildContext context) {
    // title text theme
    var titleTextTheme = Theme.of(context).textTheme.titleMedium;
    // content text theme
    var contentTextTheme = Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );

    final vm = printContractViewModel;
    final payment = vm.payment;
    final role = vm.ownRole;
    final otherUser = vm.otherUser;
    final contract = vm.printContract;

    if (payment?.paymentStatus != PaymentStatus.paymentConfirmed ||
        role == null ||
        contract == null) {
      return null;
    }

    final isHelpReceiver = role == ParticipantRole.helpReceiver;
    final isHelpProvider = role == ParticipantRole.helpProvider;
    final contractStatus = contract.contractStatus;

    // contract accepted
    if (contractStatus == PrintContractStatus.accepted) {
      if (isHelpProvider) {
        return OpenStep(
          title: Text("Druckfertigstellung bestätigen", style: titleTextTheme),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bitte bestätige, dass du das Objekt fertig gedruckt hast.",
                style: contentTextTheme,
              ),
              const SizedBox(height: 10),
              AppButton(
                onPressed: () {
                  context.read<EditPrintContractBloc>().add(
                    ConfirmDonePrintingStep6(
                      printContract: printContractViewModel.printContract!,
                    ),
                  );
                },
                child: const Text("Fertigstellung bestätigen"),
              ),
            ],
          ),
          isCompleted: false,
        );
      } else if (isHelpReceiver) {
        if (otherUser == null) {
          return const OpenStep(
            title: AppShimmerRectangular(width: 250, height: 20),
            isCompleted: false,
          );
        }

        return OpenStep(
          title: Text(
            "${otherUser.firstName} druckt jetzt",
            style: titleTextTheme,
          ),
          isCompleted: false,
        );
      }
    }

    // print confirmed
    if (isHelpProvider) {
      return OpenStep(
        title: Text(
          "Du hast die Druckfertigstellung bestätigt",
          style: titleTextTheme,
        ),
        isCompleted: true,
      );
    } else if (isHelpReceiver) {
      if (otherUser == null) {
        return const OpenStep(
          title: AppShimmerRectangular(width: 250, height: 20),
          isCompleted: true,
        );
      }

      return OpenStep(
        title: Text(
          "${otherUser.firstName} hat den Druck bestätigt",
          style: titleTextTheme,
        ),
        isCompleted: true,
      );
    }

    return null;
  }
}
