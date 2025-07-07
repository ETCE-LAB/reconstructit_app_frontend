import 'package:reconstructitapp/domain/entity_models/community_print_request.dart';
import 'package:reconstructitapp/domain/entity_models/item.dart';
import 'package:reconstructitapp/domain/entity_models/participant.dart';

import '../../domain/entity_models/chat.dart';
import '../../domain/entity_models/message.dart';
import '../../domain/entity_models/user.dart';

class ChatBodyViewModel {
  final Participant ownParticipant;
  final Participant otherParticipant;
  final User otherParticipantUser;
  final Chat chat;
  final Message lastMessage;
  final CommunityPrintRequest communityPrintRequest;
  final Item item;

  ChatBodyViewModel(
    this.otherParticipantUser,
    this.chat,
    this.lastMessage,
    this.communityPrintRequest,
    this.item,
    this.ownParticipant,
    this.otherParticipant,
  );

  /*
  Color getStatusColor(){
    switch(chat.chatStatus){
      case ChatStatus.done:
        return Color(0xFF156619);
      case ChatStatus.pending:
        return Color(0xFF9C7A00);
      case ChatStatus.agreed:
        return Color(0xFF003250);
      case ChatStatus.cancelled:
        return Color(0xFF810101);
    }}

   */
  /*
    String getStatus() {
      switch (chat.chatStatus) {
        case ChatStatus.done:
          return "Bauteil erhalten";
        case ChatStatus.pending:
          return "Einigung ausstehend";
        case ChatStatus.agreed:
          return "Geeinigt";
        case ChatStatus.cancelled:
          return "Abgebrochen";
      }
    }

 */
}
