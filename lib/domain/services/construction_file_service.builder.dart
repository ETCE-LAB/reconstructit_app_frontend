// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// WithBuilderGenerator
// **************************************************************************

part of 'construction_file_service.dart';

class ConstructionFileServiceBuilder {
  final ConstructionFileService _inner;
  ConstructionFileServiceBuilder(this._inner);
  final List<Function(ConstructionFileService)> _decorators = [];
  // append a decorator
  ConstructionFileServiceBuilder add(
    Function(ConstructionFileService) decorator,
  ) {
    _decorators.add(decorator);
    return this;
  }

  // stack all decorators
  ConstructionFileService build() {
    var result = _inner;
    for (final decorator in _decorators) {
      result = decorator(result);
    }
    return result;
  }
}
