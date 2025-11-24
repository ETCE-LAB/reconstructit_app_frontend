// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// MeasureCpuActiveTimeGenerator
// **************************************************************************

part of 'payment_service.dart';

class PaymentServiceCpuActiveTimeDecorator extends PaymentService {
  final PaymentService _inner;
  PaymentServiceCpuActiveTimeDecorator(this._inner);
  @override
  Future<Result<Payment>> createPayment(Payment payment) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.createPayment(payment);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for createPayment: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<void>> updatePayment(Payment payment) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.updatePayment(payment);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for updatePayment: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<Payment>> getPayment(String id) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.getPayment(id);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for getPayment: ${end - start}ms");
    return result;
  }
}
