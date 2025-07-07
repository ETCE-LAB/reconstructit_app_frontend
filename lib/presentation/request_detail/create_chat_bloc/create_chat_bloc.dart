import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/domain/entity_models/chat.dart';
import 'package:reconstructitapp/domain/entity_models/enums/participant_role.dart';
import 'package:reconstructitapp/domain/entity_models/participant.dart';
import 'package:reconstructitapp/domain/services/chat_service.dart';
import 'package:reconstructitapp/domain/services/participant_service.dart';
import 'package:reconstructitapp/domain/services/user_service.dart';

import 'create_chat_event.dart';
import 'create_chat_state.dart';

class CreateChatBloc extends Bloc<CreateChatEvent, CreateChatState> {
  final UserService userService;
  final ParticipantService participantService;
  final ChatService chatService;

  CreateChatBloc(this.participantService, this.chatService, this.userService)
    : super(CreateChatInitial()) {
    on<CreateChat>(_onCreateChat);
  }

  void _onCreateChat(CreateChat event, emit) async {
    emit(CreateChatLoading());
    // create chat
    var chatResult = await chatService.createChat(
      Chat(null, event.communityPrintRequestId, null),
    );
    if (!chatResult.isSuccessful) {
      print("fail 0");
      emit(CreateChatFailed(chatResult.failure!));
      return;
    }
    // create both participants
    var otherParticipant = await participantService.createParticipant(
      Participant(
        null,
        ParticipantRole.helpReceiver,
        event.otherUserId,
        chatResult.value!.id!,
      ),
    );
    if (!otherParticipant.isSuccessful) {
      print("fail 1");
      emit(CreateChatFailed(otherParticipant.failure!));
      return;
    }
    // get own user
    var userResult = await userService.getUserId();
    if (!userResult.isSuccessful) {
      print("fail 2");
      emit(CreateChatFailed(userResult.failure!));
      return;
    }
    var ownParticipant = await participantService.createParticipant(
      Participant(
        null,
        ParticipantRole.helpProvider,
        userResult.value!,
        chatResult.value!.id!,
      ),
    );
    if (!ownParticipant.isSuccessful) {
      print("fail 3");
      emit(CreateChatFailed(ownParticipant.failure!));
      return;
    }
    print("success");
    emit(CreateChatSucceeded());
  }
}
