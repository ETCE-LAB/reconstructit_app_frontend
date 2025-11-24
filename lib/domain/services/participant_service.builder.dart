// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// WithBuilderGenerator
// **************************************************************************

part of 'participant_service.dart';

class ParticipantServiceBuilder {
  final ParticipantService _inner;
  ParticipantServiceBuilder(this._inner);
  final List<Function(ParticipantService)> _decorators = [];
  // append a decorator
  ParticipantServiceBuilder add(Function(ParticipantService) decorator) {
    _decorators.add(decorator);
    return this;
  }

  // stack all decorators
  ParticipantService build() {
    var result = _inner;
    for (final decorator in _decorators) {
      result = decorator(result);
    }
    return result;
  }
}
