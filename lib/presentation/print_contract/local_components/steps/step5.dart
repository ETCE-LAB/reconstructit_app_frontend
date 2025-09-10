import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/components/AppShimmerRectangular.dart';
import 'package:reconstructitapp/domain/entity_models/enums/participant_role.dart';
import 'package:reconstructitapp/presentation/print_contract/local_components/custom_stepper.dart';
import 'package:reconstructitapp/presentation/print_contract/print_contract_view_model.dart';

import '../../../../components/AppButton.dart';
import '../../../../domain/entity_models/enums/payment_status.dart';
import '../../bloc/interaction/edit_print_contract_bloc.dart';
import '../../bloc/interaction/edit_print_contract_event.dart';

class Step5 {
  final PrintContractViewModel printContractViewModel;

  const Step5({required this.printContractViewModel});

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

    if (payment == null || role == null) return null;

    final status = payment.paymentStatus;
    final isHelpReceiver = role == ParticipantRole.helpReceiver;
    final isHelpProvider = role == ParticipantRole.helpProvider;

    // Payment done but not confirmed
    if (status == PaymentStatus.paymentDone) {
      if (otherUser == null) {
        return const OpenStep(
          title: AppShimmerRectangular(width: 250, height: 20),
          isCompleted: false,
        );
      }

      final firstName = otherUser.firstName;

      if (isHelpReceiver) {
        return OpenStep(
          title: Text(
            "$firstName muss nun den Zahlungseingang bestätigen",
            style: titleTextTheme,
          ),
          isCompleted: false,
        );
      } else if (isHelpProvider) {
        return OpenStep(
          title: Text(
            "Zahlungseingang von $firstName bestätigen",
            style: titleTextTheme,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bitte bestätige den Zahlungseingang.",
                style: contentTextTheme,
              ),
              const SizedBox(height: 10),
              AppButton(
                child: Text("Zahlungseingang bestätigen"),
                onPressed: () {
                  context.read<EditPrintContractBloc>().add(
                    ConfirmPaymentIngoingStep5(
                      payment: printContractViewModel.payment!,
                    ),
                  );
                },
              ),
            ],
          ),
          isCompleted: false,
        );
      }
    }

    // Payment confirmed
    if (status == PaymentStatus.paymentConfirmed) {
      if (otherUser == null) {
        return const OpenStep(
          title: AppShimmerRectangular(width: 250, height: 20),
          isCompleted: true,
        );
      }

      final firstName = otherUser.firstName;

      final titleText =
          isHelpReceiver
              ? "$firstName hat den Zahlungseingang bestätigt"
              : "Du hast den Zahlungseingang bestätigt";

      return OpenStep(
        title: Text(titleText, style: titleTextTheme),
        isCompleted: true,
      );
    }

    return null;
  }
}
