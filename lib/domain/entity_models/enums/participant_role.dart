import 'package:json_annotation/json_annotation.dart';

enum ParticipantRole {
  @JsonValue(0)
  helpProvider,
  @JsonValue(1)
  helpReceiver;
}