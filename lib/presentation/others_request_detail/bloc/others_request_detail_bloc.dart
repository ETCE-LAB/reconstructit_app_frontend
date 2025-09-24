import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/domain/services/community_print_request_service.dart';
import 'package:reconstructitapp/domain/services/participant_service.dart';
import 'package:reconstructitapp/domain/services/print_contract_service.dart';
import 'package:reconstructitapp/domain/services/user_service.dart';

import 'others_request_detail_event.dart';
import 'others_request_detail_state.dart';

/// this bloc is only used to check if "to process" or "offer print" should be displayed
class OthersRequestDetailBloc
    extends Bloc<OthersRequestDetailEvent, OthersRequestDetailState> {
  final CommunityPrintRequestService communityPrintRequestService;
  final PrintContractService printContractService;
  final ParticipantService participantService;
  final UserService userService;

  OthersRequestDetailBloc(
    this.communityPrintRequestService,
    this.printContractService,
    this.participantService,
    this.userService,
  ) : super(OthersRequestDetailInitial()) {
    on<OthersRequestDetailRefresh>(_onRefresh);
  }

  void _onRefresh(OthersRequestDetailRefresh event, emit) async {
    emit(OthersRequestDetailLoading());
    // get chat because there should not be own entries in the feed
    var contractResult = await printContractService.getContractsForRequest(
      event.communityPrintRequestId,
    );
    if (!contractResult.isSuccessful) {
      emit(OthersRequestDetailFailed(contractResult.failure!));
      return;
    }
    // if there are no contracts, the user can not have a contract
    if (contractResult.value!.isEmpty) {
      emit(OthersRequestDetailLoaded(printContractId: null));
      return;
    }
    // get own user id
    var userResult = await userService.getUserAccountId();
    if (!userResult.isSuccessful) {
      emit(OthersRequestDetailFailed(userResult.failure!));
      return;
    }
    // get participants for contract
    for (int i = 0; i < contractResult.value!.length; i++) {
      var participantResult = await participantService
          .getParticipantsForContract(contractResult.value![i].id!);
      if (!participantResult.isSuccessful) {
        emit(OthersRequestDetailFailed(participantResult.failure!));
        return;
      }
      var userIsParticipant = participantResult.value!.any(
        (participant) => participant.userId == userResult.value!,
      );
      if (!userIsParticipant) {
        emit(
          OthersRequestDetailLoaded(
            printContractId: contractResult.value![i].id,
          ),
        );
        return;
      }
    }
    emit(OthersRequestDetailLoaded(printContractId: null));
  }
}
