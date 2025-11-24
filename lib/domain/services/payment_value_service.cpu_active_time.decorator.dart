// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// MeasureCpuActiveTimeGenerator
// **************************************************************************

part of 'payment_value_service.dart';

class PaymentValueServiceCpuActiveTimeDecorator extends PaymentValueService {
  final PaymentValueService _inner;
  PaymentValueServiceCpuActiveTimeDecorator(this._inner);
  @override
  Future<Result<PaymentValue>> createPaymentValue(PaymentValue value) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.createPaymentValue(value);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for createPaymentValue: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<List<PaymentValue>>> getPaymentValuesForPayment(
    String methodId,
  ) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.getPaymentValuesForPayment(methodId);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for getPaymentValuesForPayment: ${end - start}ms");
    return result;
  }
}
