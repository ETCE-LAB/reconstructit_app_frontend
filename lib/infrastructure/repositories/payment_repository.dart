import '../../domain/entity_models/payment.dart';
import '../../domain/services/payment_service.dart';
import '../../utils/result.dart';
import '../sources/remote_datasource.dart';

class PaymentRepository implements PaymentService {
  final IRemoteDatasource remoteDatasource;

  PaymentRepository(this.remoteDatasource);

  @override
  Future<Result<Payment>> createPayment(Payment payment) async {
    try {
      return Result.success(await remoteDatasource.createPayment(payment));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<void>> updatePayment(Payment payment) async {
    try {
      await remoteDatasource.updatePayment(payment.id!, payment);
      return Result.success(() {});
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<Payment>> getPayment(String id) async {
    try {
      return Result.success(await remoteDatasource.getPayment(id));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }
}
