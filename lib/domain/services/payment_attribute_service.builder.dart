// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// WithBuilderGenerator
// **************************************************************************

part of 'payment_attribute_service.dart';

class PaymentAttributeServiceBuilder {
  final PaymentAttributeService _inner;
  PaymentAttributeServiceBuilder(this._inner);
  final List<Function(PaymentAttributeService)> _decorators = [];
  // append a decorator
  PaymentAttributeServiceBuilder add(
    Function(PaymentAttributeService) decorator,
  ) {
    _decorators.add(decorator);
    return this;
  }

  // stack all decorators
  PaymentAttributeService build() {
    var result = _inner;
    for (final decorator in _decorators) {
      result = decorator(result);
    }
    return result;
  }
}
