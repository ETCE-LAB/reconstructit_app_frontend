import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/components/app_button.dart';
import 'package:reconstructitapp/components/app_secondary_button.dart';
import 'package:reconstructitapp/components/app_shimmer_rectangular.dart';
import 'package:reconstructitapp/domain/entity_models/enums/participant_role.dart';
import 'package:reconstructitapp/presentation/print_contract/local_components/custom_stepper.dart';
import 'package:reconstructitapp/presentation/print_contract/print_contract_view_model.dart';

import '../../../../domain/entity_models/enums/print_contract_status.dart';
import '../../bloc/interaction/edit_print_contract_bloc.dart';
import '../../bloc/interaction/edit_print_contract_event.dart';

class Step3 {
  final PrintContractViewModel printContractViewModel;

  const Step3({required this.printContractViewModel});

  OpenStep? build(BuildContext context) {
    // title text theme
    var titleTextTheme = Theme.of(context).textTheme.titleMedium;
    // content text theme
    var contentTextTheme = Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );
    if (printContractViewModel.printContract == null) {
      return null;
    }

    if (printContractViewModel.ownRole == null) {
      return null;
    }

    final isHelpReceiver =
        printContractViewModel.ownRole == ParticipantRole.helpReceiver;
    final isHelpProvider =
        printContractViewModel.ownRole == ParticipantRole.helpProvider;
    final address = printContractViewModel.address;
    final contractAccepted =
        printContractViewModel.printContract!.contractStatus !=
        PrintContractStatus.pending;
    final isCompleted =
        printContractViewModel.printContract?.revealedAddressId != null;

    if (!contractAccepted) return null;
    final addressLines = [
      printContractViewModel.ownUser != null
          ? Text(
            "${printContractViewModel.ownUser?.firstName ?? 'Vorname'} ${printContractViewModel.ownUser?.lastName ?? 'Nachname'}",
            style: contentTextTheme,
          )
          : AppShimmerRectangular(width: 100, height: 15),
      address != null
          ? Text(address.streetAndHouseNumber, style: contentTextTheme)
          : AppShimmerRectangular(width: 100, height: 15),
      address != null
          ? Text(
            "${address.zipCode} ${address.city}".trim(),
            style: contentTextTheme,
          )
          : AppShimmerRectangular(width: 100, height: 15),
      address != null
          ? Text(address.country, style: contentTextTheme)
          : AppShimmerRectangular(width: 100, height: 15),
    ];

    if (!isCompleted) {
      if (isHelpReceiver) {
        return OpenStep(
          title: Text("Versandadresse senden", style: titleTextTheme),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: addressLines.map((line) => line).toList(),
              ),
              const SizedBox(height: 10),
              AppButton(
                child: Text("Diese Adresse angeben"),
                onPressed: () {
                  context.read<EditPrintContractBloc>().add(
                    ConfirmAddressStep3(
                      printContract: printContractViewModel.printContract!,
                      addressId: address!.id!,
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Text(
                "Bis zur Bezahlung kannst du dieses Angebot weiterhin ausschlagen.",
                style: contentTextTheme,
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
          isCompleted: isCompleted,
        );
      } else if (isHelpProvider) {
        return OpenStep(
          title: Text(
            "${printContractViewModel.otherUser?.firstName ?? 'Vorname'} wird dir nun die Versandadresse senden",
            style: titleTextTheme,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Du kannst dieses Angebot bis zur Bezahlung zurückziehen.",
                style: contentTextTheme,
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
          isCompleted: isCompleted,
        );
      }
    }

    // === CASE 2: Address is available ===
    if (isCompleted) {
      final title =
          isHelpReceiver
              ? Text(
                "Du hast deine Versandadresse gesendet",
                style: titleTextTheme,
              )
              : printContractViewModel.otherUser != null
              ? Text(
                "${printContractViewModel.otherUser?.firstName ?? 'Vorname'} hat dir die Versandadresse gesendet",
                style: titleTextTheme,
              )
              : AppShimmerRectangular(width: 100, height: 15);

      return OpenStep(
        title: title,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: addressLines.map((line) => line).toList(),
        ),
        isCompleted: isCompleted,
      );
    }

    return const OpenStep(
      title: AppShimmerRectangular(width: 100, height: 15),
      isCompleted: false,
    );
  }
}
