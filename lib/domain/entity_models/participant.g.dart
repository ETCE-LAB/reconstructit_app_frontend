// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Participant _$ParticipantFromJson(Map<String, dynamic> json) => Participant(
  json['id'] as String?,
  $enumDecode(_$ParticipantRoleEnumMap, json['participantRole']),
  json['userId'] as String?,
  json['chatId'] as String,
);

Map<String, dynamic> _$ParticipantToJson(Participant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'participantRole': _$ParticipantRoleEnumMap[instance.participantRole]!,
      'userId': instance.userId,
      'chatId': instance.chatId,
    };

const _$ParticipantRoleEnumMap = {
  ParticipantRole.helpProvider: 0,
  ParticipantRole.helpReceiver: 1,
};
