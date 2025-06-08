import 'package:json_annotation/json_annotation.dart';
import 'package:reconstructitapp/domain/entity_models/entity.dart';
import 'package:reconstructitapp/domain/entity_models/enums/chat_status.dart';


part 'chat.g.dart';

@JsonSerializable()
class Chat extends Entity {
  final ChatStatus chatStatus;
  final String communityPrintRequestId;
  final String? lastMessage;
  final String? addressId;
  Chat(super.id, this.chatStatus, this.communityPrintRequestId,
      this.lastMessage, this.addressId);

  factory Chat.fromJson(Map<String, dynamic> json) =>
      _$ChatFromJson(json);


  Map<String, dynamic> toJson() => _$ChatToJson(this);



}