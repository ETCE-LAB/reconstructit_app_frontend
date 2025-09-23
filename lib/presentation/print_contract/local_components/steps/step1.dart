import 'package:flutter/material.dart';
import 'package:reconstructitapp/components/app_shimmer_rectangular.dart';
import 'package:reconstructitapp/domain/entity_models/enums/participant_role.dart';
import 'package:reconstructitapp/presentation/print_contract/local_components/custom_stepper.dart';
import 'package:reconstructitapp/presentation/print_contract/print_contract_view_model.dart';

class Step1 {
  final PrintContractViewModel printContractViewModel;

  const Step1({required this.printContractViewModel});

  OpenStep build(BuildContext context) {
    // title text theme
    var titleTextTheme = Theme.of(context).textTheme.titleMedium;
    // content text theme
    var contentTextTheme = Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );
    // build title
    String? title;
    if (printContractViewModel.ownRole != null) {
      if (printContractViewModel.ownRole! == ParticipantRole.helpProvider) {
        title = "Du hast ein Angebot gemacht";
        if (printContractViewModel.otherUser != null) {
          title =
              "Du hast ${printContractViewModel.otherUser!.firstName} ein Angebot gemacht";
        }
      } else {
        if (printContractViewModel.otherUser != null) {
          title =
              "${printContractViewModel.otherUser!.firstName} hat dir ein Angebot gemacht";
        } else {
          title = "hat dir ein Angebot gemacht";
        }
      }
    }
    // build content
    Widget content1;

    final role = printContractViewModel.ownRole;
    final user = printContractViewModel.otherUser;
    final price = printContractViewModel.communityPrintRequest?.priceMax;

    if (role == null) {
      content1 = const AppShimmerRectangular(width: 180, height: 15);
    } else {
      final isHelpProvider = role == ParticipantRole.helpProvider;
      final name = user?.firstName;
      final priceText = price != null ? "${price.toStringAsFixed(2)}€" : null;

      if (name == null || priceText == null) {
        content1 = const AppShimmerRectangular(width: 180, height: 15);
      } else {
        final text =
            isHelpProvider
                ? "$name soll dir $priceText zahlen."
                : "Du sollst $name $priceText zahlen.";

        content1 = Text(
          text,
          style: contentTextTheme,
          softWrap: true,
          overflow: TextOverflow.clip,
        );
      }
    }

    Widget content2;
    final material =
        printContractViewModel.communityPrintRequest?.printMaterial;

    if (role == null) {
      content2 = const AppShimmerRectangular(width: 180, height: 15);
    } else {
      final isHelpReceiver = role == ParticipantRole.helpReceiver;
      final name = user?.firstName;
      final materialText = material?.toString();

      if ((isHelpReceiver && name == null) || materialText == null) {
        content2 = const AppShimmerRectangular(width: 180, height: 15);
      } else {
        final text =
            isHelpReceiver
                ? "$name druckt mit $materialText"
                : "Du druckst mit $materialText";

        content2 = Text(text, style: contentTextTheme);
      }
    }

    Widget content3;

    final payment = printContractViewModel.paymentMethod?.name;

    if (role == null) {
      content3 = const AppShimmerRectangular(width: 180, height: 15);
    } else {
      final isHelpReceiver = role == ParticipantRole.helpReceiver;
      final name = user?.firstName;
      final paymentText = payment;

      if (name == null || paymentText == null) {
        content3 = const AppShimmerRectangular(width: 180, height: 15);
      } else {
        final text =
            isHelpReceiver
                ? "$name möchte die Zahlung mit $paymentText abwickeln."
                : "$name soll mit $paymentText zahlen.";

        content3 = Text(text, style: contentTextTheme);
      }
    }

    Widget content4;

    final attributes = printContractViewModel.paymentAttributes;
    final values = printContractViewModel.paymentValues;

    if (attributes == null || values == null) {
      content4 = const AppShimmerRectangular(width: 180, height: 15);
    } else {
      content4 = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            attributes.map((attribute) {
              final matchingValues =
                  values
                      .where(
                        (value) => value.paymentAttributeId == attribute.id,
                      )
                      .map((v) => v.value)
                      .toList();

              final valueText =
                  matchingValues.isNotEmpty ? matchingValues.join(", ") : "–";

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  "${attribute.key}: $valueText",
                  softWrap: true,
                  style: contentTextTheme,
                ),
              );
            }).toList(),
      );
    }

    return OpenStep(
      title:
          title != null
              ? Text(title, style: titleTextTheme)
              : AppShimmerRectangular(width: 100, height: 15),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 5.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [content1, content2, content3, content4],
      ),
      isCompleted: true,
    );
  }
}
