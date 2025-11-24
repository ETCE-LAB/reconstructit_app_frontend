// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// MeasureCpuActiveTimeGenerator
// **************************************************************************

part of 'payment_attribute_service.dart';

class PaymentAttributeServiceCpuActiveTimeDecorator
    extends PaymentAttributeService {
  final PaymentAttributeService _inner;
  PaymentAttributeServiceCpuActiveTimeDecorator(this._inner);
  @override
  Future<Result<List<PaymentAttribute>>> getAttributesForDefinition(
    String id,
  ) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.getAttributesForDefinition(id);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for getAttributesForDefinition: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<PaymentAttribute>> getPaymentAttribute(String id) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.getPaymentAttribute(id);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for getPaymentAttribute: ${end - start}ms");
    return result;
  }
}
