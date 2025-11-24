// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// WithBuilderGenerator
// **************************************************************************

part of 'media_service.dart';

class MediaServiceBuilder {
  final MediaService _inner;
  MediaServiceBuilder(this._inner);
  final List<Function(MediaService)> _decorators = [];
  // append a decorator
  MediaServiceBuilder add(Function(MediaService) decorator) {
    _decorators.add(decorator);
    return this;
  }

  // stack all decorators
  MediaService build() {
    var result = _inner;
    for (final decorator in _decorators) {
      result = decorator(result);
    }
    return result;
  }
}
