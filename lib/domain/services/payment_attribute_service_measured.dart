import 'package:reconstructitapp/domain/services/payment_attribute_service.dart';
import 'package:reconstructitapp/measuring/platform_channel/cpu_active_time_platform_channel.dart';

import '../../utils/result.dart';
import '../entity_models/payment_attribute.dart';

class PaymentAttributeServiceMeasured extends PaymentAttributeService {
  final PaymentAttributeService _inner;

  PaymentAttributeServiceMeasured(this._inner);

  @override
  Future<Result<List<PaymentAttribute>>> getAttributesForDefinition(
    String id,
  ) async {
    final start = await CPUActiveTimePlatformChannel.getCPUTime();
    var result = await _inner.getAttributesForDefinition(id);
    final end = await CPUActiveTimePlatformChannel.getCPUTime();
    if (end != -1 && start != -1) {
      print("CPU ACTIVE TIME (getAttributesForDefinition): ${end - start} ms");
    }
    return result;
  }

  @override
  Future<Result<PaymentAttribute>> getPaymentAttribute(String id) async {
    final start = await CPUActiveTimePlatformChannel.getCPUTime();
    var result = await _inner.getPaymentAttribute(id);
    final end = await CPUActiveTimePlatformChannel.getCPUTime();
    if (end != -1 && start != -1) {
      print("CPU ACTIVE TIME (getPaymentAttribute): ${end - start} ms");
    }
    return result;
  }
}
