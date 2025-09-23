import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/domain/services/community_print_request_service.dart';
import 'package:reconstructitapp/domain/services/item_service.dart';
import 'package:reconstructitapp/domain/services/participant_service.dart';
import 'package:reconstructitapp/domain/services/payment_service.dart';
import 'package:reconstructitapp/domain/services/print_contract_service.dart';
import 'package:reconstructitapp/domain/services/user_service.dart';
import 'package:reconstructitapp/presentation/print_contract/print_contract_view_model.dart';

import 'print_contract_event.dart';
import 'print_contract_state.dart';

class AllPrintContractsBloc
    extends Bloc<AllPrintContractsEvent, AllPrintContractsState> {
  final UserService userService;
  final ParticipantService participantService;
  final PrintContractService printContractService;
  final CommunityPrintRequestService communityPrintRequestService;
  final ItemService itemService;
  final PaymentService paymentService;

  //final ChatService chatService;

  AllPrintContractsBloc(
    this.userService,
    this.participantService,
    this.communityPrintRequestService,
    this.printContractService,
    this.itemService,
    this.paymentService,
  ) : super(AllPrintContractsInitial()) {
    on<AllPrintContractsRefresh>(_onRefresh);
  }

  void _onRefresh(event, emit) async {
    emit(AllPrintContractsLoading());
    // get own user
    var userResult = await userService.getCurrentUser();
    if (!userResult.isSuccessful) {
      emit(AllPrintContractsFailed(userResult.failure!));
      return;
    }
    // get all participants for user
    var participantsResult = await participantService.getParticipantsForUser(
      userResult.value!.id!,
    );
    if (!participantsResult.isSuccessful) {
      emit(AllPrintContractsFailed(participantsResult.failure!));
      return;
    }
    List<PrintContractViewModel> vms = [];
    for (int i = 0; i < participantsResult.value!.length; i++) {
      // get participants for print contract
      var participantsForPrintContractResult = await participantService
          .getParticipantsForContract(
            participantsResult.value![i].printContractId,
          );
      if (!participantsForPrintContractResult.isSuccessful) {
        emit(
          AllPrintContractsFailed(participantsForPrintContractResult.failure!),
        );
        return;
      }
      // filter the other participant
      var otherParticipant = participantsForPrintContractResult.value!
          .firstWhere(
            (participant) => participant.userId != userResult.value!.id,
          );
      // get user for the other participant
      var otherUserResult = await userService.getUser(otherParticipant.userId!);
      if (!otherUserResult.isSuccessful) {
        emit(AllPrintContractsFailed(otherUserResult.failure!));
        return;
      }
      // get the print contract
      var printContractResult = await printContractService.getContract(
        participantsResult.value![i].printContractId,
      );
      if (!printContractResult.isSuccessful) {
        emit(AllPrintContractsFailed(printContractResult.failure!));
        return;
      }
      // get payment
      var paymentResult = await paymentService.getPayment(
        printContractResult.value!.paymentId!,
      );
      if (!paymentResult.isSuccessful) {
        emit(AllPrintContractsFailed(paymentResult.failure!));
        return;
      }
      // get community print request
      var communityPrintRequest = await communityPrintRequestService
          .getCommunityPrintRequest(
            printContractResult.value!.communityPrintRequestId,
          );
      if (!communityPrintRequest.isSuccessful) {
        emit(AllPrintContractsFailed(communityPrintRequest.failure!));
        return;
      }
      // get item
      var itemResult = await itemService.getItem(
        communityPrintRequest.value!.itemId,
      );
      if (!itemResult.isSuccessful) {
        emit(AllPrintContractsFailed(itemResult.failure!));
        return;
      }
      var vm = PrintContractViewModel(
        isLoading: false,
        otherUser: otherUserResult.value!,
        printContract: printContractResult.value!,
        communityPrintRequest: communityPrintRequest.value!,
        payment: paymentResult.value!,
        item: itemResult.value!,
      );
      vms.add(vm);
    }

    emit(AllPrintContractsLoaded(vms));
  }
}
