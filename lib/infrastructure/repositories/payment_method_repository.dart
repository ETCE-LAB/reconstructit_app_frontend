import '../../domain/entity_models/payment_method.dart';
import '../../domain/services/payment_method_service.dart';
import '../../utils/result.dart';
import '../sources/remote_datasource.dart';

class PaymentMethodRepository implements PaymentMethodService {
  final IRemoteDatasource remoteDatasource;

  PaymentMethodRepository(this.remoteDatasource);

  @override
  Future<Result<List<PaymentMethod>>> getPaymentMethods() async {
    try {
      return Result.success(await remoteDatasource.getAllPaymentMethods());
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<PaymentMethod>> getPaymentMethod(String id) async {
    try {
      return Result.success(await remoteDatasource.getPaymentMethod(id));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }
}
