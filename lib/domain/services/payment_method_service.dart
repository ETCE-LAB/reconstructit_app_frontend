import '../../utils/result.dart';
import '../entity_models/payment_method.dart';

abstract class PaymentMethodService {
  Future<Result<List<PaymentMethod>>> getPaymentMethods();

  Future<Result<PaymentMethod>> getPaymentMethod(String id);
}
