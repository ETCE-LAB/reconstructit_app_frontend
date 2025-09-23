import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/components/app_button.dart';
import 'package:reconstructitapp/components/app_secondary_button.dart';
import 'package:reconstructitapp/domain/entity_models/enums/participant_role.dart';
import 'package:reconstructitapp/presentation/print_contract/local_components/custom_stepper.dart';
import 'package:reconstructitapp/presentation/print_contract/print_contract_view_model.dart';

import '../../../../domain/entity_models/enums/payment_status.dart';
import '../../bloc/interaction/edit_print_contract_bloc.dart';
import '../../bloc/interaction/edit_print_contract_event.dart';

class Step4 {
  final PrintContractViewModel printContractViewModel;

  const Step4({required this.printContractViewModel});

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

    if (role == null || payment == null) return null;

    final isHelpReceiver = role == ParticipantRole.helpReceiver;
    final isHelpProvider = role == ParticipantRole.helpProvider;

    if (payment.paymentStatus != PaymentStatus.pending) {
      final titleText =
          isHelpReceiver
              ? "Du hast die Zahlung an ${otherUser?.firstName ?? 'Vorname'} bestätigt"
              : "${otherUser?.firstName ?? 'Vorname'} hat den Zahlungsausgang bestätigt";

      return OpenStep(title: Text(titleText, style: titleTextTheme,), isCompleted: true);
    }

    if (vm.printContract?.revealedAddressId != null &&
        payment.paymentStatus == PaymentStatus.pending) {
      if (isHelpReceiver) {
        return OpenStep(
          title: Text(
            "Zahlung an ${otherUser?.firstName ?? 'Vorname'} bestätigen",style: titleTextTheme
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text("Bitte bestätige den Zahlungsausgang.",style: contentTextTheme),
              const SizedBox(height: 10),
              AppButton(
                child: Text("Zahlung bestätigen"),
                onPressed: () {
                  context.read<EditPrintContractBloc>().add(
                    ConfirmPaymentOutgoingStep4(
                      payment: printContractViewModel.payment!,
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
               Text(
                "Bis zur Bezahlung kannst du dieses Angebot weiterhin ausschlagen.",style: contentTextTheme,
              ),
              const SizedBox(height: 10),
              AppSecondaryButton(
                child: Text("Angebot ausschlagen"),
                onPressed: () {
                  context.read<EditPrintContractBloc>().add(
                    CancelOffer(
                      printContract: printContractViewModel.printContract!,
                    ),
                  );
                },
              ),
            ],
          ),
          isCompleted: false,
        );
      } else if (isHelpProvider) {
        return OpenStep(
          title: Text("${otherUser?.firstName ?? 'Vorname'} zahlt jetzt", style: titleTextTheme,),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                "Du kannst dieses Angebot bis zur Bezahlung zurückziehen.",style: contentTextTheme,
              ),
              const SizedBox(height: 10),
              AppSecondaryButton(
                child: Text("Angebot zurückziehen"),
                onPressed: () {
                  context.read<EditPrintContractBloc>().add(
                    CancelOffer(
                      printContract: printContractViewModel.printContract!,
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

    return null;
  }
}
