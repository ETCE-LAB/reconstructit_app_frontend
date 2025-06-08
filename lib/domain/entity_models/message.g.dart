// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
  json['id'] as String?,
  json['content'] as String,
  DateTime.parse(json['sentAt'] as String),
  json['participantId'] as String?,
  json['chatId'] as String,
);

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
  'id': instance.id,
  'content': instance.content,
  'sentAt': instance.sentAt.toIso8601String(),
  'participantId': instance.participantId,
  'chatId': instance.chatId,
};
