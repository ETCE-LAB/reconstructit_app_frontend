// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
  json['id'] as String?,
  $enumDecode(_$ChatStatusEnumMap, json['chatStatus']),
  json['communityPrintRequestId'] as String,
  json['lastMessage'] as String?,
  json['addressId'] as String?,
);

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
  'id': instance.id,
  'chatStatus': _$ChatStatusEnumMap[instance.chatStatus]!,
  'communityPrintRequestId': instance.communityPrintRequestId,
  'lastMessage': instance.lastMessage,
  'addressId': instance.addressId,
};

const _$ChatStatusEnumMap = {
  ChatStatus.pending: 0,
  ChatStatus.agreed: 1,
  ChatStatus.done: 2,
  ChatStatus.cancelled: 3,
};
