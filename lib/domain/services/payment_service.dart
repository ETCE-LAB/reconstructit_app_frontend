import '../../utils/result.dart';
import '../entity_models/payment.dart';

abstract class PaymentService {
  Future<Result<Payment>> createPayment(Payment payment);

  Future<Result<void>> updatePayment(Payment payment);

  Future<Result<Payment>> getPayment(String id);
}
