import 'package:reconstructitapp/domain/entity_models/payment_attribute.dart';
import 'package:reconstructitapp/domain/entity_models/payment_method.dart';

/// Viewmodel: A Payment Method and the belonging attributes
class PaymentMethodViewModel {
  final PaymentMethod paymentMethod;
  final List<PaymentAttribute> paymentAttributes;

  const PaymentMethodViewModel({
    required this.paymentMethod,
    required this.paymentAttributes,
  });
}
