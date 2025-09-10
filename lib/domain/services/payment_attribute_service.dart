import '../../utils/result.dart';
import '../entity_models/payment_attribute.dart';

abstract class PaymentAttributeService {
  Future<Result<List<PaymentAttribute>>> getAttributesForDefinition(String id);

  Future<Result<PaymentAttribute>> getPaymentAttribute(String id);
}
