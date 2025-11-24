// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// MeasureCpuActiveTimeGenerator
// **************************************************************************

part of 'payment_method_service.dart';

class PaymentMethodServiceCpuActiveTimeDecorator extends PaymentMethodService {
  final PaymentMethodService _inner;
  PaymentMethodServiceCpuActiveTimeDecorator(this._inner);
  @override
  Future<Result<List<PaymentMethod>>> getPaymentMethods() async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.getPaymentMethods();
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for getPaymentMethods: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<PaymentMethod>> getPaymentMethod(String id) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.getPaymentMethod(id);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for getPaymentMethod: ${end - start}ms");
    return result;
  }
}
