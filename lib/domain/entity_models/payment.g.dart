// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
  json['id'] as String?,
  $enumDecode(_$PaymentStatusEnumMap, json['paymentStatus']),
  json['paymentMethodId'] as String,
  json['printContractId'] as String,
);

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
  'id': instance.id,
  'paymentStatus': _$PaymentStatusEnumMap[instance.paymentStatus]!,
  'paymentMethodId': instance.paymentMethodId,
  'printContractId': instance.printContractId,
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 0,
  PaymentStatus.paymentDone: 1,
  PaymentStatus.paymentConfirmed: 2,
};
