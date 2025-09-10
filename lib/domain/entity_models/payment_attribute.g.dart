// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentAttribute _$PaymentAttributeFromJson(Map<String, dynamic> json) =>
    PaymentAttribute(
      json['id'] as String?,
      json['key'] as String,
      json['paymentMethodId'] as String,
    );

Map<String, dynamic> _$PaymentAttributeToJson(PaymentAttribute instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'paymentMethodId': instance.paymentMethodId,
    };
