// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// WithBuilderGenerator
// **************************************************************************

part of 'user_service.dart';

class UserServiceBuilder {
  final UserService _inner;
  UserServiceBuilder(this._inner);
  final List<Function(UserService)> _decorators = [];
  // append a decorator
  UserServiceBuilder add(Function(UserService) decorator) {
    _decorators.add(decorator);
    return this;
  }

  // stack all decorators
  UserService build() {
    var result = _inner;
    for (final decorator in _decorators) {
      result = decorator(result);
    }
    return result;
  }
}
