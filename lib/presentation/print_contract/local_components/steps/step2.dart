import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/components/AppButton.dart';
import 'package:reconstructitapp/components/AppSecondaryButton.dart';
import 'package:reconstructitapp/components/AppShimmerRectangular.dart';
import 'package:reconstructitapp/domain/entity_models/enums/participant_role.dart';
import 'package:reconstructitapp/domain/entity_models/enums/print_contract_status.dart';
import 'package:reconstructitapp/presentation/print_contract/bloc/interaction/edit_print_contract_bloc.dart';
import 'package:reconstructitapp/presentation/print_contract/bloc/interaction/edit_print_contract_event.dart';
import 'package:reconstructitapp/presentation/print_contract/local_components/custom_stepper.dart';
import 'package:reconstructitapp/presentation/print_contract/print_contract_view_model.dart';

class Step2 {
  final PrintContractViewModel printContractViewModel;

  const Step2({required this.printContractViewModel});

  OpenStep build(BuildContext context) {
    // title text theme
    var titleTextTheme = Theme.of(context).textTheme.titleMedium;
    // content text theme
    var contentTextTheme = Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );
    final contract = printContractViewModel.printContract;
    final role = printContractViewModel.ownRole;

    if (contract == null || role == null) {
      return const OpenStep(
        title: AppShimmerRectangular(width: 100, height: 15),
        isCompleted: false,
      );
    }

    final status = contract.contractStatus;
    final otherUser = printContractViewModel.otherUser;

    // Fallback in case otherUser is null
    final otherFirstName = otherUser== null?"..." :otherUser!.firstName;

    final isHelpProvider = role == ParticipantRole.helpProvider;
    final isHelpReceiver = role == ParticipantRole.helpReceiver;

    if (status == PrintContractStatus.pending) {
      if (isHelpReceiver) {
        return OpenStep(
          title: Text(
            "Du kannst jetzt das Angebot annehmen",
            style: titleTextTheme,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppButton(
                child: Text("Angebot annehmen"),
                onPressed: () {
                  context.read<EditPrintContractBloc>().add(
                    AcceptOfferStep2(
                      printContract: printContractViewModel.printContract!,
                    ),
                  );
                },
              ),
              TextButton(
                onPressed: () {
                  context.read<EditPrintContractBloc>().add(
                    CancelOffer(
                      printContract: printContractViewModel.printContract!,
                    ),
                  );
                },
                child: Text("Angebot aussschlagen"),
              ),
            ],
          ),
          isCompleted: false,
        );
      } else {
        return OpenStep(
          title:
              otherFirstName == null
                  ? AppShimmerRectangular(width: 100, height: 15)
                  : Text(
                    "$otherFirstName muss nun dein Angebot annehmen",
                    style: titleTextTheme,
                  ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Du kannst dieses Angebot bis zur Bezahlung zurückziehen.",
                softWrap: true,
                style: contentTextTheme,
              ),
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

    if (isHelpProvider) {
      return OpenStep(
        title: Text(
          "$otherFirstName hat das Angebot angenommen",
          style: titleTextTheme,
        ),
        isCompleted: true,
      );
    } else {
      return OpenStep(
        title: Text("Du hast das Angebot angenommen", style: titleTextTheme),
        isCompleted: true,
      );
    }
  }
}
