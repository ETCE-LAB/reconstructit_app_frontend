import '../../domain/entity_models/payment_attribute.dart';
import '../../domain/services/payment_attribute_service.dart';
import '../../utils/result.dart';
import '../sources/remote_datasource.dart';

class PaymentAttributeRepositoryWithLogging implements PaymentAttributeService {
  final IRemoteDatasource remoteDatasource;

  PaymentAttributeRepositoryWithLogging(this.remoteDatasource);

  @override
  Future<Result<List<PaymentAttribute>>> getAttributesForDefinition(
    String id,
  ) async {
    print('[LOG] getAttributesForDefinition mit folgender id aufgerufen: $id');
    try {
      var result = await remoteDatasource.getPaymentAttributesForDefinition(id);
      print(
        '[LOG] getAttributesForDefinition Ergebnis: ${result.map((a) => a.toJson()).toList()}',
      );
      return Result.success(result);
    } catch (e) {
      print('[LOG] getAttributesForDefinition fehlgeschlagen, Fehler: $e');
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<PaymentAttribute>> getPaymentAttribute(String id) async {
    print('[LOG] getPaymentAttribute mit folgender id aufgerufen: $id');
    try {
      var result = await remoteDatasource.getPaymentAttribute(id);
      print('[LOG] getPaymentAttribute Ergebnis: ${result.toJson()}');
      return Result.success(result);
    } catch (e) {
      print('[LOG] getPaymentAttribute fehlgeschlagen, Fehler: $e');
      return Result.fail(e as Exception);
    }
  }
}
