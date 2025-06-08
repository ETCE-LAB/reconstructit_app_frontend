import 'package:json_annotation/json_annotation.dart';
import 'package:reconstructitapp/domain/entity_models/entity.dart';

import 'enums/participant_role.dart';

part 'participant.g.dart';

@JsonSerializable()
class Participant extends Entity {

  final ParticipantRole participantRole;
  final String? userId;
  final String chatId;

  Participant(super.id, this.participantRole, this.userId, this.chatId);


  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);


  Map<String, dynamic> toJson() => _$ParticipantToJson(this);
}