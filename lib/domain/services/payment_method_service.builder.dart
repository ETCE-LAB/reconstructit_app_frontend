// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// WithBuilderGenerator
// **************************************************************************

part of 'payment_method_service.dart';

class PaymentMethodServiceBuilder {
  final PaymentMethodService _inner;
  PaymentMethodServiceBuilder(this._inner);
  final List<Function(PaymentMethodService)> _decorators = [];
  // append a decorator
  PaymentMethodServiceBuilder add(Function(PaymentMethodService) decorator) {
    _decorators.add(decorator);
    return this;
  }

  // stack all decorators
  PaymentMethodService build() {
    var result = _inner;
    for (final decorator in _decorators) {
      result = decorator(result);
    }
    return result;
  }
}
