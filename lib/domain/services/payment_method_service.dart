import 'package:clean_ressource_tracker/clean_ressource_tracker.dart';

import '../../utils/result.dart';
import '../entity_models/payment_method.dart';

part 'payment_method_service.cpu_active_time.decorator.dart';
part 'payment_method_service.builder.dart';

@WithBuilder()
@MeasureCpuActiveTime()
abstract class PaymentMethodService {
  Future<Result<List<PaymentMethod>>> getPaymentMethods();

  Future<Result<PaymentMethod>> getPaymentMethod(String id);
}
