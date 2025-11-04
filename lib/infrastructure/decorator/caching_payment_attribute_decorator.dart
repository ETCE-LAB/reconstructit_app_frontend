import '../../domain/entity_models/payment_attribute.dart';
import '../../domain/services/payment_attribute_service.dart';
import '../../utils/result.dart';

class CachingPaymentAttributeDecorator implements PaymentAttributeService {
  final PaymentAttributeService _inner;
  final Map<String, dynamic> _cache = {};

  CachingPaymentAttributeDecorator(this._inner);

  @override
  Future<Result<List<PaymentAttribute>>> getAttributesForDefinition(String id) async {
    if (_cache.containsKey(id)) {
      print('[CACHE HIT] getAttributesForDefinition $id');
      return Result.success(_cache[id]);
    }
    print('[NO CACHE HIT] getAttributesForDefinition $id');
    final result = await _inner.getAttributesForDefinition(id);
    if (result.isSuccessful) {
      _cache[id] = result.value;
    }
    return result;
  }

  @override
  Future<Result<PaymentAttribute>> getPaymentAttribute(String id) async {
    if (_cache.containsKey(id)) {
      print('[CACHE HIT] getPaymentAttribute $id');
      return Result.success(_cache[id]);
    }
    print('[NO CACHE HIT] getAttributesForDefinition $id');
    final result = await _inner.getPaymentAttribute(id);
    if (result.isSuccessful) {
      _cache[id] = result.value;
    }
    return result;
  }
}
