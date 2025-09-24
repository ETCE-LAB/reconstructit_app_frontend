import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/components/app_button.dart';
import 'package:reconstructitapp/components/app_text_field.dart';
import 'package:reconstructitapp/presentation/choose_payment_method_and_create_print_contract/payment_method_view_model.dart';

import '../../domain/entity_models/user.dart';
import '../print_contract/print_contract_screen.dart';
import 'bloc/create_print_contract/create_print_contract_bloc.dart';
import 'bloc/create_print_contract/create_print_contract_event.dart';
import 'bloc/create_print_contract/create_print_contract_state.dart';

/// The bottom sheet to choose a payment method
/// Takes values with text fields to the attributes of the chosen method
/// Created the Print Contract on Button click
class ChoosePaymentBottomSheetBody extends StatefulWidget {
  final String communityPrintRequestId;
  final User otherUser;
  final List<PaymentMethodViewModel> paymentMethodViewModels;

  const ChoosePaymentBottomSheetBody({
    super.key,
    required this.paymentMethodViewModels,
    required this.communityPrintRequestId,
    required this.otherUser,
  });

  @override
  ChoosePaymentBottomSheetBodyState createState() =>
      ChoosePaymentBottomSheetBodyState();
}

class ChoosePaymentBottomSheetBodyState
    extends State<ChoosePaymentBottomSheetBody> {
  // controller for every text field
  Map<String, Map<String, TextEditingController>> controllers = {};

  late String methodValue;

  @override
  void initState() {
    super.initState();
    methodValue = widget.paymentMethodViewModels[0].paymentMethod.id!;
    for (var methodVM in widget.paymentMethodViewModels) {
      final methodId = methodVM.paymentMethod.id!;
      controllers[methodId] = {};
      for (var attr in methodVM.paymentAttributes) {
        controllers[methodId]![attr.key] = TextEditingController();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePrintContractBloc, CreatePrintContractState>(
      listener: (context, state) {
        if (state is CreatePrintContractSucceeded) {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => PrintContractScreen(
                    printContractId: state.printContractId,
                  ),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text(
              'Wie soll ${widget.otherUser.firstName} zahlen?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.paymentMethodViewModels.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final vm = widget.paymentMethodViewModels[index];

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Radio<String>(
                        value: vm.paymentMethod.id!,
                        groupValue: methodValue,
                        onChanged: (value) {
                          setState(() {
                            methodValue = value!;
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            Text(
                              vm.paymentMethod.name,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            const SizedBox(height: 8),
                            ...vm.paymentAttributes.map(
                              (attr) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: AppTextField(
                                  controller:
                                      controllers[vm.paymentMethod.id]![attr
                                          .key]!,
                                  hint: attr.key,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.surface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton(
                  child: Text("Druck anbieten"),
                  onPressed: () {
                    final selectedMethod = widget.paymentMethodViewModels
                        .firstWhere((vm) => vm.paymentMethod.id == methodValue);

                    final List<CreatePrintPaymentViewModel> paymentValues =
                        selectedMethod.paymentAttributes.map((attr) {
                          final controller =
                              controllers[methodValue]![attr.key]!;
                          return CreatePrintPaymentViewModel(
                            paymentValue: controller.text,
                            paymentAttributeId: attr.id!,
                          );
                        }).toList();
                    context.read<CreatePrintContractBloc>().add(
                      CreatePrintContract(
                        communityPrintRequestId: widget.communityPrintRequestId,
                        otherUserId: widget.otherUser.id!,
                        paymentMethodId: methodValue,
                        paymentValues: paymentValues,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
