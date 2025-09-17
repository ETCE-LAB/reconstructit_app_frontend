import 'package:json_annotation/json_annotation.dart';
import 'package:reconstructitapp/domain/entity_models/entity.dart';

part 'payment_attribute.g.dart';

@JsonSerializable()
class PaymentAttribute extends Entity {
  final String key;
  final String paymentMethodId;

  PaymentAttribute(super.id, this.key, this.paymentMethodId);

  factory PaymentAttribute.fromJson(Map<String, dynamic> json) =>
      _$PaymentAttributeFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentAttributeToJson(this);
}
