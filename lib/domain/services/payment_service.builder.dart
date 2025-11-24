// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// WithBuilderGenerator
// **************************************************************************

part of 'payment_service.dart';

class PaymentServiceBuilder {
  final PaymentService _inner;
  PaymentServiceBuilder(this._inner);
  final List<Function(PaymentService)> _decorators = [];
  // append a decorator
  PaymentServiceBuilder add(Function(PaymentService) decorator) {
    _decorators.add(decorator);
    return this;
  }

  // stack all decorators
  PaymentService build() {
    var result = _inner;
    for (final decorator in _decorators) {
      result = decorator(result);
    }
    return result;
  }
}
