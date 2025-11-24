import 'package:clean_ressource_tracker/clean_ressource_tracker.dart';

import '../../utils/result.dart';
import '../entity_models/payment.dart';

part 'payment_service.cpu_active_time.decorator.dart';
part 'payment_service.builder.dart';

@WithBuilder()
@MeasureCpuActiveTime()
abstract class PaymentService {
  Future<Result<Payment>> createPayment(Payment payment);

  Future<Result<void>> updatePayment(Payment payment);

  Future<Result<Payment>> getPayment(String id);
}
