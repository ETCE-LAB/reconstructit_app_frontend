// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// WithBuilderGenerator
// **************************************************************************

part of 'item_image_service.dart';

class ItemImageServiceBuilder {
  final ItemImageService _inner;
  ItemImageServiceBuilder(this._inner);
  final List<Function(ItemImageService)> _decorators = [];
  // append a decorator
  ItemImageServiceBuilder add(Function(ItemImageService) decorator) {
    _decorators.add(decorator);
    return this;
  }

  // stack all decorators
  ItemImageService build() {
    var result = _inner;
    for (final decorator in _decorators) {
      result = decorator(result);
    }
    return result;
  }
}
