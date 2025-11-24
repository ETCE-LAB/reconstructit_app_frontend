// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// WithBuilderGenerator
// **************************************************************************

part of 'address_service.dart';

class AddressServiceBuilder {
  final AddressService _inner;
  AddressServiceBuilder(this._inner);
  final List<Function(AddressService)> _decorators = [];
  // append a decorator
  AddressServiceBuilder add(Function(AddressService) decorator) {
    _decorators.add(decorator);
    return this;
  }

  // stack all decorators
  AddressService build() {
    var result = _inner;
    for (final decorator in _decorators) {
      result = decorator(result);
    }
    return result;
  }
}
