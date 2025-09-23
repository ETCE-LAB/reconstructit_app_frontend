import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/domain/services/community_print_request_service.dart';
import 'package:reconstructitapp/domain/services/participant_service.dart';
import 'package:reconstructitapp/domain/services/print_contract_service.dart';
import 'package:reconstructitapp/domain/services/user_service.dart';

import 'request_detail_event.dart';
import 'request_detail_state.dart';

class RequestDetailBloc extends Bloc<RequestDetailEvent, RequestDetailState> {
  final CommunityPrintRequestService communityPrintRequestService;
  final PrintContractService printContractService;
  final ParticipantService participantService;
  final UserService userService;

  //final ChatService chatService;

  RequestDetailBloc(
    this.communityPrintRequestService,
    this.printContractService,
    this.participantService,
    this.userService,
  ) : super(RequestDetailInitial()) {
    on<RequestDetailRefresh>(_onRefresh);
  }

  void _onRefresh(RequestDetailRefresh event, emit) async {
    emit(RequestDetailLoading());
    // get chat because there should not be own entries in the feed
    var contractResult = await printContractService.getContractsForRequest(
      event.communityPrintRequestId,
    );
    if (!contractResult.isSuccessful) {
      emit(RequestDetailFailed(contractResult.failure!));
      return;
    }
    // if there are no contracts, the user cannnot have a contract
    if (contractResult.value!.isEmpty) {
      emit(RequestDetailLoaded(alreadyHasChat: false));
      return;
    }
    // get own user id
    var userResult = await userService.getUserAccountId();
    if (!userResult.isSuccessful) {
      emit(RequestDetailFailed(userResult.failure!));
      return;
    }
    // get participants for contract
    for (int i = 0; i < contractResult.value!.length; i++) {
      var participantResult = await participantService
          .getParticipantsForContract(contractResult.value![i].id!);
      if (!participantResult.isSuccessful) {
        emit(RequestDetailFailed(participantResult.failure!));
        return;
      }
      var userIsParticipant = participantResult.value!.any(
        (participant) => participant.userId == userResult.value!,
      );
      if (!userIsParticipant) {
        emit(RequestDetailLoaded(alreadyHasChat: true));
        return;
      }
    }
    emit(RequestDetailLoaded(alreadyHasChat: false));
  }
}
