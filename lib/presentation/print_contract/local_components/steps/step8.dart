import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/components/AppShimmerRectangular.dart';
import 'package:reconstructitapp/domain/entity_models/enums/participant_role.dart';
import 'package:reconstructitapp/domain/entity_models/enums/shipping_status.dart';
import 'package:reconstructitapp/presentation/print_contract/local_components/custom_stepper.dart';
import 'package:reconstructitapp/presentation/print_contract/print_contract_view_model.dart';

import '../../../../components/AppButton.dart';
import '../../bloc/interaction/edit_print_contract_bloc.dart';
import '../../bloc/interaction/edit_print_contract_event.dart';

class Step8 {
  final PrintContractViewModel printContractViewModel;

  const Step8({required this.printContractViewModel});

  OpenStep? build(BuildContext context) {
    // title text theme
    var titleTextTheme = Theme.of(context).textTheme.titleMedium;
    // content text theme
    var contentTextTheme = Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );

    final vm = printContractViewModel;
    final role = vm.ownRole;
    final contract = vm.printContract;
    final otherUser = vm.otherUser;

    if (role == null || contract == null) return null;

    final shippingStatus = contract.shippingStatus;

    if (shippingStatus == ShippingStatus.pending) return null;

    final isHelpReceiver = role == ParticipantRole.helpReceiver;
    final isHelpProvider = role == ParticipantRole.helpProvider;

    // shipping sent but not received
    if (shippingStatus == ShippingStatus.sent) {
      if (isHelpReceiver) {
        return OpenStep(
          title: Text("Empfang bestätigen", style: titleTextTheme),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bitte bestätige, dass du das Objekt empfangen hast.",
                style: contentTextTheme,
              ),
              const SizedBox(height: 10),
              AppButton(
                onPressed: () {
                  context.read<EditPrintContractBloc>().add(
                    ConfirmReceivingStep8(
                      printContract: printContractViewModel.printContract!,
                    ),
                  );
                },
                child: const Text("Empfang bestätigen"),
              ),
            ],
          ),
          isCompleted: false,
        );
      } else if (isHelpProvider) {
        if (otherUser == null) {
          return const OpenStep(
            title: AppShimmerRectangular(width: 250, height: 20),
            isCompleted: false,
          );
        }

        return OpenStep(
          title: Text(
            "${otherUser.firstName} muss nun den Empfang bestätigen",
            style: titleTextTheme,
          ),
          isCompleted: false,
        );
      }
    }

    // object received
    if (shippingStatus == ShippingStatus.received) {
      if (isHelpReceiver) {
        return OpenStep(
          title: Text("Du hast den Empfang bestätigt", style: titleTextTheme),
          isCompleted: true,
        );
      } else if (isHelpProvider) {
        if (otherUser == null) {
          return const OpenStep(
            title: AppShimmerRectangular(width: 250, height: 20),
            isCompleted: true,
          );
        }

        return OpenStep(
          title: Text(
            "${otherUser.firstName} hat den Empfang bestätigt",
            style: titleTextTheme,
          ),
          isCompleted: true,
        );
      }
    }

    return null;
  }
}
