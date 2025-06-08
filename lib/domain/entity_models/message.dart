import 'package:json_annotation/json_annotation.dart';
import 'package:reconstructitapp/domain/entity_models/entity.dart';


part 'message.g.dart';

@JsonSerializable()
class Message extends Entity{
  final String content;
  final DateTime sentAt;
  final String? participantId;
  final String chatId;

  Message(super.id, this.content, this.sentAt, this.participantId, this.chatId);

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);


  Map<String, dynamic> toJson() => _$MessageToJson(this);


}