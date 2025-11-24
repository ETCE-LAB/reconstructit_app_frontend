// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// WithBuilderGenerator
// **************************************************************************

part of 'payment_value_service.dart';

class PaymentValueServiceBuilder {
  final PaymentValueService _inner;
  PaymentValueServiceBuilder(this._inner);
  final List<Function(PaymentValueService)> _decorators = [];
  // append a decorator
  PaymentValueServiceBuilder add(Function(PaymentValueService) decorator) {
    _decorators.add(decorator);
    return this;
  }

  // stack all decorators
  PaymentValueService build() {
    var result = _inner;
    for (final decorator in _decorators) {
      result = decorator(result);
    }
    return result;
  }
}
