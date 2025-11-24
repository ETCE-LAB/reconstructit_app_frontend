// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// WithBuilderGenerator
// **************************************************************************

part of 'print_contract_service.dart';

class PrintContractServiceBuilder {
  final PrintContractService _inner;
  PrintContractServiceBuilder(this._inner);
  final List<Function(PrintContractService)> _decorators = [];
  // append a decorator
  PrintContractServiceBuilder add(Function(PrintContractService) decorator) {
    _decorators.add(decorator);
    return this;
  }

  // stack all decorators
  PrintContractService build() {
    var result = _inner;
    for (final decorator in _decorators) {
      result = decorator(result);
    }
    return result;
  }
}
