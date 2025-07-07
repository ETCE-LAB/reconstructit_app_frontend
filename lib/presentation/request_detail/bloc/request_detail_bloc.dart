import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/domain/services/chat_service.dart';
import 'package:reconstructitapp/domain/services/community_print_request_service.dart';
import 'package:reconstructitapp/domain/services/item_image_service.dart';
import 'package:reconstructitapp/domain/services/item_service.dart';

import 'request_detail_event.dart';
import 'request_detail_state.dart';

class RequestDetailBloc extends Bloc<RequestDetailEvent, RequestDetailState> {
  final ItemService itemService;
  final ItemImageService itemImageService;
  final CommunityPrintRequestService communityPrintRequestService;
  final ChatService chatService;

  //final ChatService chatService;

  RequestDetailBloc(
    this.itemService,
    this.itemImageService,
    this.communityPrintRequestService,
    this.chatService,
  ) : super(RequestDetailInitial()) {
    on<RequestDetailRefresh>(_onRefresh);
  }

  void _onRefresh(RequestDetailRefresh event, emit) async {
    emit(RequestDetailLoading());
    // get chat because there should not be own entries in the feed
    var chatResult = await chatService.getChatsForCommunityPrintRequest(
      event.communityPrintRequestId,
    );
    if (chatResult.isSuccessful) {
      emit(RequestDetailLoaded(chatResult.value!.isNotEmpty ? true : false));
    } else {
      print("==========");
      print(chatResult.failure!);
      emit(RequestDetailFailed(chatResult.failure!));
    }
  }
}
