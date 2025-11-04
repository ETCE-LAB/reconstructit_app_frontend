import '../../domain/entity_models/payment_attribute.dart';
import '../../domain/services/payment_attribute_service.dart';
import '../../utils/result.dart';

class LoggingPaymentAttributeDecorator implements PaymentAttributeService {
  final PaymentAttributeService _inner;

  LoggingPaymentAttributeDecorator(this._inner);

  @override
  Future<Result<List<PaymentAttribute>>> getAttributesForDefinition(
    String id,
  ) async {
    print('[LOG] getAttributesForDefinition mit folgender id aufgerufen: $id');
    final result = await _inner.getAttributesForDefinition(id);
    print('[LOG] getAttributesForDefinition Ergebnis: $result');
    return result;
  }

  @override
  Future<Result<PaymentAttribute>> getPaymentAttribute(String id) async {
    print('[LOG] getPaymentAttribute mit folgender id aufgerufen: $id');
    final result = await _inner.getPaymentAttribute(id);
    print('[LOG] getPaymentAttribute Ergebnis: $result');
    return result;
  }
}
