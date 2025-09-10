import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/choose_payment_method/bloc/payment_methods_bloc.dart';
import 'package:reconstructitapp/presentation/choose_payment_method/bloc/payment_methods_event.dart';
import 'package:reconstructitapp/presentation/choose_payment_method/bloc/payment_methods_state.dart';
import 'package:reconstructitapp/presentation/choose_payment_method/choose_payment_bottom_sheet_body.dart';

import '../../domain/entity_models/user.dart';
import '../../utils/dependencies.dart';
import '../request_detail/create_chat_bloc/create_print_contract_bloc.dart';

class ChoosePaymentBottomSheet extends StatefulWidget {
  final User otherUser;

  final String communityPrintRequestId;

  const ChoosePaymentBottomSheet({
    super.key,
    required this.otherUser,
    required this.communityPrintRequestId,
  });

  @override
  ChoosePaymentBottomSheetState createState() =>
      ChoosePaymentBottomSheetState();
}

class ChoosePaymentBottomSheetState extends State<ChoosePaymentBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ic<PaymentMethodsBloc>()..add(PaymentMethodsRefresh()),
        ),
        BlocProvider(create: (_) => ic<CreatePrintContractBloc>()),
      ],
      child: BlocBuilder<PaymentMethodsBloc, PaymentMethodsState>(
        builder: (context, state) {
          if (state is PaymentMethodsLoading) {
            return CircularProgressIndicator();
          } else if (state is PaymentMethodsLoaded) {
            return ChoosePaymentBottomSheetBody(
              otherUser: widget.otherUser,
              communityPrintRequestId: widget.communityPrintRequestId,
              paymentMethodViewModels: state.paymentMethodViewModels,
            );
          }
          return Container();
        },
      ),
    );
  }
}
