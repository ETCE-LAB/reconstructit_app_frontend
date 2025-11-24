// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// WithBuilderGenerator
// **************************************************************************

part of 'community_print_request_service.dart';

class CommunityPrintRequestServiceBuilder {
  final CommunityPrintRequestService _inner;
  CommunityPrintRequestServiceBuilder(this._inner);
  final List<Function(CommunityPrintRequestService)> _decorators = [];
  // append a decorator
  CommunityPrintRequestServiceBuilder add(
    Function(CommunityPrintRequestService) decorator,
  ) {
    _decorators.add(decorator);
    return this;
  }

  // stack all decorators
  CommunityPrintRequestService build() {
    var result = _inner;
    for (final decorator in _decorators) {
      result = decorator(result);
    }
    return result;
  }
}
