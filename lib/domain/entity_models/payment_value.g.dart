// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentValue _$PaymentValueFromJson(Map<String, dynamic> json) => PaymentValue(
  json['id'] as String?,
  json['value'] as String,
  json['paymentAttributeId'] as String,
  json['paymentId'] as String,
);

Map<String, dynamic> _$PaymentValueToJson(PaymentValue instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'paymentAttributeId': instance.paymentAttributeId,
      'paymentId': instance.paymentId,
    };
