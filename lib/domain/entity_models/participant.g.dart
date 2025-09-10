// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Participant _$ParticipantFromJson(Map<String, dynamic> json) => Participant(
  json['id'] as String?,
  $enumDecode(_$ParticipantRoleEnumMap, json['role']),
  json['userId'] as String?,
  json['printContractId'] as String,
);

Map<String, dynamic> _$ParticipantToJson(Participant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'role': _$ParticipantRoleEnumMap[instance.role]!,
      'userId': instance.userId,
      'printContractId': instance.printContractId,
    };

const _$ParticipantRoleEnumMap = {
  ParticipantRole.helpProvider: 0,
  ParticipantRole.helpReceiver: 1,
};
