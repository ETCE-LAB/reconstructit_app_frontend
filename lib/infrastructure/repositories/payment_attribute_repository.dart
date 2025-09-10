import '../../domain/entity_models/payment_attribute.dart';
import '../../domain/services/payment_attribute_service.dart';
import '../../utils/result.dart';
import '../sources/remote_datasource.dart';

class PaymentAttributeRepository implements PaymentAttributeService {
  final IRemoteDatasource remoteDatasource;

  PaymentAttributeRepository(this.remoteDatasource);

  @override
  Future<Result<List<PaymentAttribute>>> getAttributesForDefinition(
    String id,
  ) async {
    try {
      return Result.success(
        await remoteDatasource.getPaymentAttributesForDefinition(id),
      );
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<PaymentAttribute>> getPaymentAttribute(String id) async {
    try {
      return Result.success(await remoteDatasource.getPaymentAttribute(id));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }
}
