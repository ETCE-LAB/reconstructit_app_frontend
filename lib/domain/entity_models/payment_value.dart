import 'package:json_annotation/json_annotation.dart';
import 'package:reconstructitapp/domain/entity_models/entity.dart';

part 'payment_value.g.dart';

@JsonSerializable()
class PaymentValue extends Entity {
  final String value;
  final String paymentAttributeId;
  final String paymentId;

  PaymentValue(super.id, this.value, this.paymentAttributeId, this.paymentId);

  factory PaymentValue.fromJson(Map<String, dynamic> json) =>
      _$PaymentValueFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentValueToJson(this);
}
