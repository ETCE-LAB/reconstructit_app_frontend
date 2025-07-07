
class CreateChatEvent {}

class CreateChat extends CreateChatEvent {
  final String communityPrintRequestId;
  final String otherUserId;
  CreateChat(this.communityPrintRequestId, this.otherUserId);
}
