import '../../domain/entity_models/payment_value.dart';
import '../../domain/services/payment_value_service.dart';
import '../../utils/result.dart';
import '../sources/remote_datasource.dart';

class PaymentValueRepository implements PaymentValueService {
  final IRemoteDatasource remoteDatasource;

  PaymentValueRepository(this.remoteDatasource);

  @override
  Future<Result<PaymentValue>> createPaymentValue(PaymentValue value) async {
    try {
      return Result.success(await remoteDatasource.createPaymentValue(value));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<List<PaymentValue>>> getPaymentValuesForPayment(
    String methodId,
  ) async {
    try {
      return Result.success(
        await remoteDatasource.getPaymentValuesForPayment(methodId),
      );
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }
}
