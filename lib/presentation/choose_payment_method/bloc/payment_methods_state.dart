import 'package:reconstructitapp/presentation/choose_payment_method/payment_method_view_model.dart';

abstract class PaymentMethodsState {}

class PaymentMethodsInitial extends PaymentMethodsState {}

class PaymentMethodsLoading extends PaymentMethodsState {}

class PaymentMethodsLoaded extends PaymentMethodsState {
  final List<PaymentMethodViewModel> paymentMethodViewModels;

  PaymentMethodsLoaded({required this.paymentMethodViewModels});
}

class PaymentMethodsFailed extends PaymentMethodsState {
  final Exception exception;

  PaymentMethodsFailed(this.exception);
}
