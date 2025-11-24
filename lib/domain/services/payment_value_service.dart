import 'package:clean_ressource_tracker/clean_ressource_tracker.dart';

import '../../utils/result.dart';
import '../entity_models/payment_value.dart';

part 'payment_value_service.cpu_active_time.decorator.dart';
part 'payment_value_service.builder.dart';

@WithBuilder()
@MeasureCpuActiveTime()
abstract class PaymentValueService {
  Future<Result<PaymentValue>> createPaymentValue(PaymentValue value);

  Future<Result<List<PaymentValue>>> getPaymentValuesForPayment(String methodId);
}
