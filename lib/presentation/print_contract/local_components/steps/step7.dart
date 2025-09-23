import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/components/app_shimmer_rectangular.dart';
import 'package:reconstructitapp/domain/entity_models/enums/participant_role.dart';
import 'package:reconstructitapp/domain/entity_models/enums/print_contract_status.dart';
import 'package:reconstructitapp/domain/entity_models/enums/shipping_status.dart';
import 'package:reconstructitapp/presentation/print_contract/local_components/custom_stepper.dart';
import 'package:reconstructitapp/presentation/print_contract/print_contract_view_model.dart';

import '../../../../components/app_button.dart';
import '../../bloc/interaction/edit_print_contract_bloc.dart';
import '../../bloc/interaction/edit_print_contract_event.dart';

class Step7 {
  final PrintContractViewModel printContractViewModel;

  const Step7({required this.printContractViewModel});

  OpenStep? build(BuildContext context) {
    // title text theme
    var titleTextTheme = Theme.of(context).textTheme.titleMedium;
    // content text theme
    var contentTextTheme = Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );

    final vm = printContractViewModel;
    final role = vm.ownRole;
    final otherUser = vm.otherUser;
    final contract = vm.printContract;

    if (role == null || contract == null) return null;

    // Step is hidden if print contract still only accepted
    if (contract.contractStatus == PrintContractStatus.accepted ||
        contract.contractStatus == PrintContractStatus.pending) {
      return null;
    }

    final shippingStatus = contract.shippingStatus;

    final isHelpReceiver = role == ParticipantRole.helpReceiver;
    final isHelpProvider = role == ParticipantRole.helpProvider;

    // shipping is pending
    if (shippingStatus == ShippingStatus.pending) {
      if (isHelpProvider) {
        return OpenStep(
          title: Text("Versand bestätigen", style: titleTextTheme),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bitte bestätige, dass du das Objekt an die oben genannte Adresse versendet hast.",
                style: contentTextTheme,
              ),
              const SizedBox(height: 10),
              AppButton(
                onPressed: () {
                  context.read<EditPrintContractBloc>().add(
                    ConfirmSendingStep7(
                      printContract: printContractViewModel.printContract!,
                    ),
                  );
                },
                child: const Text("Versand bestätigen"),
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
            "${otherUser.firstName} versendet jetzt den Druck",
            style: titleTextTheme,
          ),
          isCompleted: false,
        );
      }
    }

    if (shippingStatus != ShippingStatus.pending) {
      if (isHelpProvider) {
        return OpenStep(
          title: Text("Du hast den Versand bestätigt", style: titleTextTheme),
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
            "${otherUser.firstName} hat den Versand bestätigt",
            style: titleTextTheme,
          ),
          isCompleted: true,
        );
      }
    }

    return null;
  }
}
