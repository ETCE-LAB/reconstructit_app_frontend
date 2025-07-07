// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
  json['id'] as String?,
  json['communityPrintRequestId'] as String,
  json['addressId'] as String?,
);

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
  'id': instance.id,
  'communityPrintRequestId': instance.communityPrintRequestId,
  'addressId': instance.addressId,
};
