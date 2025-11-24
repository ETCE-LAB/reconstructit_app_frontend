import 'package:clean_ressource_tracker/clean_ressource_tracker.dart';
import '../../utils/result.dart';
import '../entity_models/payment_attribute.dart';

part 'payment_attribute_service.builder.dart';
part 'payment_attribute_service.cpu_active_time.decorator.dart';

@WithBuilder()
@MeasureCpuActiveTime()
abstract class PaymentAttributeService {
  Future<Result<List<PaymentAttribute>>> getAttributesForDefinition(String id);

  Future<Result<PaymentAttribute>> getPaymentAttribute(String id);
}
