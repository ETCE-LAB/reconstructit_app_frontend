import '../../utils/result.dart';
import '../entity_models/payment_value.dart';

abstract class PaymentValueService {
  Future<Result<PaymentValue>> createPaymentValue(PaymentValue value);

  Future<Result<List<PaymentValue>>> getPaymentValuesForPayment(String methodId);
}
