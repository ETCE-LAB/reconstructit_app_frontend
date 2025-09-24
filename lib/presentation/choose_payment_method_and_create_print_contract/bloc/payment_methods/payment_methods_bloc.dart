import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/domain/services/payment_attribute_service.dart';
import 'package:reconstructitapp/domain/services/payment_method_service.dart';
import 'package:reconstructitapp/presentation/choose_payment_method_and_create_print_contract/bloc/payment_methods/payment_methods_state.dart';

import '../../payment_method_view_model.dart';
import 'payment_methods_event.dart';

/// Gets the different paymentMethods and their Attributes
class PaymentMethodsBloc
    extends Bloc<PaymentMethodsEvent, PaymentMethodsState> {
  final PaymentMethodService paymentMethodService;
  final PaymentAttributeService paymentAttributeService;

  PaymentMethodsBloc(this.paymentAttributeService, this.paymentMethodService)
    : super(PaymentMethodsInitial()) {
    on<PaymentMethodsRefresh>(_onRefresh);
  }

  void _onRefresh(PaymentMethodsRefresh event, emit) async {
    emit(PaymentMethodsLoading());
    // get all paymentMethods
    var paymentMethodResult = await paymentMethodService.getPaymentMethods();
    if (!paymentMethodResult.isSuccessful) {
      emit(PaymentMethodsFailed(paymentMethodResult.failure!));
      return;
    }
    List<PaymentMethodViewModel> viewModels = [];
    // get attributes for methods
    for (int i = 0; i < paymentMethodResult.value!.length; i++) {
      var paymentMethodAttribute = await paymentAttributeService
          .getAttributesForDefinition(paymentMethodResult.value![i].id!);
      if (!paymentMethodAttribute.isSuccessful) {
        emit(PaymentMethodsFailed(paymentMethodAttribute.failure!));
        return;
      }
      viewModels.add(
        PaymentMethodViewModel(
          paymentMethod: paymentMethodResult.value![i],
          paymentAttributes: paymentMethodAttribute.value!,
        ),
      );
    }

    emit(PaymentMethodsLoaded(paymentMethodViewModels: viewModels));
  }
}
