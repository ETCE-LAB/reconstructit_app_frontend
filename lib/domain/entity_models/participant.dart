import 'package:json_annotation/json_annotation.dart';
import 'package:reconstructitapp/domain/entity_models/entity.dart';

import 'enums/participant_role.dart';

part 'participant.g.dart';

@JsonSerializable()
class Participant extends Entity {
  final ParticipantRole role;
  final String? userId;
  final String printContractId;

  Participant(super.id, this.role, this.userId, this.printContractId);

  factory Participant.fromJson(Map<String, dynamic> json) =>
      _$ParticipantFromJson(json);

  Map<String, dynamic> toJson() => _$ParticipantToJson(this);
}
