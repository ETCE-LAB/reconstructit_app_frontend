// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'print_contract.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrintContract _$PrintContractFromJson(Map<String, dynamic> json) =>
    PrintContract(
      json['id'] as String?,
      $enumDecode(_$PrintContractStatusEnumMap, json['contractStatus']),
      $enumDecode(_$ShippingStatusEnumMap, json['shippingStatus']),
      json['paymentId'] as String?,
      json['revealedAddressId'] as String?,
      json['communityPrintRequestId'] as String,
    );

Map<String, dynamic> _$PrintContractToJson(PrintContract instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contractStatus': _$PrintContractStatusEnumMap[instance.contractStatus]!,
      'shippingStatus': _$ShippingStatusEnumMap[instance.shippingStatus]!,
      'paymentId': instance.paymentId,
      'revealedAddressId': instance.revealedAddressId,
      'communityPrintRequestId': instance.communityPrintRequestId,
    };

const _$PrintContractStatusEnumMap = {
  PrintContractStatus.pending: 0,
  PrintContractStatus.accepted: 1,
  PrintContractStatus.printed: 2,
  PrintContractStatus.done: 3,
  PrintContractStatus.disputed: 4,
  PrintContractStatus.cancelled: 5,
};

const _$ShippingStatusEnumMap = {
  ShippingStatus.pending: 0,
  ShippingStatus.sent: 1,
  ShippingStatus.received: 2,
};
