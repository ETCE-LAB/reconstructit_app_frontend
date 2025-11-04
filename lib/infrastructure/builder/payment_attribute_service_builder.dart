import '../../domain/services/payment_attribute_service.dart';

class PaymentAttributeServiceBuilder {
  final PaymentAttributeService _service;

  PaymentAttributeServiceBuilder(this._service);

  final List<Function(PaymentAttributeService)> _decorators = [];

  // Füge einen Decorator hinzu
  PaymentAttributeServiceBuilder add(
      Function(PaymentAttributeService) decorator) {
    _decorators.add(decorator);
    return this;
  }

  // Build: alle Decorators stapeln
  PaymentAttributeService build() {
    var result = _service;
    for (final decorator in _decorators) {
      result = decorator(result);
    }
    return result;
  }
}
