// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// WithBuilderGenerator
// **************************************************************************

part of 'item_service.dart';

class ItemServiceBuilder {
  final ItemService _inner;
  ItemServiceBuilder(this._inner);
  final List<Function(ItemService)> _decorators = [];
  // append a decorator
  ItemServiceBuilder add(Function(ItemService) decorator) {
    _decorators.add(decorator);
    return this;
  }

  // stack all decorators
  ItemService build() {
    var result = _inner;
    for (final decorator in _decorators) {
      result = decorator(result);
    }
    return result;
  }
}
