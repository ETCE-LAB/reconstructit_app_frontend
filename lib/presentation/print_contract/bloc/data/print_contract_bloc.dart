import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/domain/entity_models/construction_file.dart';
import 'package:reconstructitapp/domain/entity_models/enums/participant_role.dart';
import 'package:reconstructitapp/domain/entity_models/enums/print_contract_status.dart';
import 'package:reconstructitapp/domain/services/address_service.dart';
import 'package:reconstructitapp/domain/services/community_print_request_service.dart';
import 'package:reconstructitapp/domain/services/construction_file_service.dart';
import 'package:reconstructitapp/domain/services/item_image_service.dart';
import 'package:reconstructitapp/domain/services/item_service.dart';
import 'package:reconstructitapp/domain/services/participant_service.dart';
import 'package:reconstructitapp/domain/services/payment_attribute_service.dart';
import 'package:reconstructitapp/domain/services/payment_method_service.dart';
import 'package:reconstructitapp/domain/services/payment_value_service.dart';
import 'package:reconstructitapp/domain/services/print_contract_service.dart';
import 'package:reconstructitapp/domain/services/user_service.dart';
import 'package:reconstructitapp/presentation/print_contract/bloc/data/print_contract_state.dart';
import 'package:reconstructitapp/presentation/print_contract/print_contract_view_model.dart';

import '../../../../domain/services/payment_service.dart';
import 'print_contract_event.dart';

class PrintContractBloc extends Bloc<PrintContractEvent, PrintContractState> {
  final UserService userService;
  final ParticipantService participantService;
  final PrintContractService printContractService;
  final CommunityPrintRequestService communityPrintRequestService;
  final PaymentService paymentService;
  final PaymentMethodService paymentMethodService;
  final PaymentValueService paymentValueService;
  final PaymentAttributeService paymentAttributeService;
  final AddressService addressService;
  final ItemService itemService;
  final ItemImageService itemImageService;
  final ConstructionFileService constructionFileService;

  //final ChatService chatService;

  PrintContractBloc(
    this.userService,
    this.participantService,
    this.communityPrintRequestService,
    this.printContractService,
    this.paymentService,
    this.paymentMethodService,
    this.paymentValueService,
    this.paymentAttributeService,
    this.addressService,
    this.itemService,
    this.itemImageService,
    this.constructionFileService,
  ) : super(PrintContractInitial()) {
    on<PrintContractRefresh>(_onRefresh);
  }

  void _onRefresh(PrintContractRefresh event, emit) async {
    // create empty view model
    var vm = PrintContractViewModel(isLoading: true);
    emit(PrintContractLoaded(vm));
    // get print contract
    var printContract = await printContractService.getContract(
      event.printContractId,
    );
    if (!printContract.isSuccessful) {
      emit(PrintContractFailed(printContract.failure!));
      return;
    }
    emit(
      PrintContractLoaded(
        PrintContractViewModel(
          isLoading: true,
          printContract: printContract.value!,
        ),
      ),
    );
    // get participants
    var participants = await participantService.getParticipantsForContract(
      printContract.value!.id!,
    );
    if (!participants.isSuccessful) {
      emit(PrintContractFailed(printContract.failure!));
      return;
    }
    // get own user
    var ownUser = await userService.getCurrentUser();

    if (!ownUser.isSuccessful || ownUser.value == null) {
      emit(PrintContractFailed(ownUser.failure!));
      return;
    }
    var ownParticipant = participants.value!.firstWhere(
      (participant) => participant.userId == ownUser.value!.id,
    );
    emit(
      PrintContractLoaded(
        PrintContractViewModel(
          isLoading: true,
          printContract: printContract.value!,
          ownRole: ownParticipant.role,
          ownUser: ownUser.value!,
        ),
      ),
    );
    // get other user
    var otherParticipant = participants.value!.firstWhere(
      (participant) => participant.userId != ownUser.value!.id!,
    );
    var otherUser = await userService.getUser(otherParticipant.userId!);
    if (!otherUser.isSuccessful) {
      emit(PrintContractFailed(otherUser.failure!));
      return;
    }
    emit(
      PrintContractLoaded(
        PrintContractViewModel(
          isLoading: true,
          printContract: printContract.value!,
          ownRole: ownParticipant.role,
          otherUser: otherUser.value!,
          ownUser: ownUser.value!,
        ),
      ),
    );
    // get communityPrintRequest
    var communityPrintRequest = await communityPrintRequestService
        .getCommunityPrintRequest(printContract.value!.communityPrintRequestId);
    if (!communityPrintRequest.isSuccessful) {
      emit(PrintContractFailed(communityPrintRequest.failure!));
      return;
    }

    emit(
      PrintContractLoaded(
        PrintContractViewModel(
          isLoading: true,
          printContract: printContract.value!,
          ownRole: ownParticipant.role,
          otherUser: otherUser.value!,
          communityPrintRequest: communityPrintRequest.value!,
          ownUser: ownUser.value!,
        ),
      ),
    );
    // get payment
    var payment = await paymentService.getPayment(
      printContract.value!.paymentId!,
    );
    if (!payment.isSuccessful) {
      emit(PrintContractFailed(payment.failure!));
      return;
    }
    emit(
      PrintContractLoaded(
        PrintContractViewModel(
          isLoading: true,
          printContract: printContract.value!,
          ownRole: ownParticipant.role,
          otherUser: otherUser.value!,
          communityPrintRequest: communityPrintRequest.value!,
          payment: payment.value!,
          ownUser: ownUser.value!,
        ),
      ),
    );
    // get payment Method
    var paymentMethod = await paymentMethodService.getPaymentMethod(
      payment.value!.paymentMethodId,
    );
    if (!paymentMethod.isSuccessful) {
      emit(PrintContractFailed(paymentMethod.failure!));
      return;
    }
    emit(
      PrintContractLoaded(
        PrintContractViewModel(
          isLoading: true,
          printContract: printContract.value!,
          ownRole: ownParticipant.role,
          otherUser: otherUser.value!,
          communityPrintRequest: communityPrintRequest.value!,
          payment: payment.value!,
          paymentMethod: paymentMethod.value!,
          ownUser: ownUser.value!,
        ),
      ),
    );
    // get paymentAttributes
    var paymentAttributes = await paymentAttributeService
        .getAttributesForDefinition(paymentMethod.value!.id!);
    if (!paymentAttributes.isSuccessful) {
      emit(PrintContractFailed(paymentAttributes.failure!));
      return;
    }

    emit(
      PrintContractLoaded(
        PrintContractViewModel(
          isLoading: true,
          printContract: printContract.value!,
          ownRole: ownParticipant.role,
          otherUser: otherUser.value!,
          communityPrintRequest: communityPrintRequest.value!,
          payment: payment.value!,
          paymentMethod: paymentMethod.value!,
          paymentAttributes: paymentAttributes.value!,
          ownUser: ownUser.value!,
        ),
      ),
    );
    // get paymentValues
    var paymentValues = await paymentValueService.getPaymentValuesForPayment(
      payment.value!.id!,
    );
    if (!paymentValues.isSuccessful) {
      emit(PrintContractFailed(paymentValues.failure!));
      return;
    }
    emit(
      PrintContractLoaded(
        PrintContractViewModel(
          isLoading: true,
          printContract: printContract.value!,
          ownRole: ownParticipant.role,
          otherUser: otherUser.value!,
          communityPrintRequest: communityPrintRequest.value!,
          payment: payment.value!,
          paymentMethod: paymentMethod.value!,
          paymentAttributes: paymentAttributes.value!,
          paymentValues: paymentValues.value!,
          ownUser: ownUser.value!,
        ),
      ),
    );
    // get item image
    var imageResult = await itemImageService.getItemImagesForItem(
      communityPrintRequest.value!.itemId,
    );
    if (!imageResult.isSuccessful) {
      emit(PrintContractFailed(imageResult.failure!));
      return;
    }
    emit(
      PrintContractLoaded(
        PrintContractViewModel(
          isLoading: true,
          printContract: printContract.value!,
          ownRole: ownParticipant.role,
          otherUser: otherUser.value!,
          communityPrintRequest: communityPrintRequest.value!,
          payment: payment.value!,
          paymentMethod: paymentMethod.value!,
          paymentAttributes: paymentAttributes.value!,
          paymentValues: paymentValues.value!,
          ownUser: ownUser.value!,
          itemImages: imageResult.value!,
        ),
      ),
    );
    // get item
    var item = await itemService.getItem(communityPrintRequest.value!.itemId);
    if (!item.isSuccessful) {
      emit(PrintContractFailed(item.failure!));
      return;
    }

    emit(
      PrintContractLoaded(
        PrintContractViewModel(
          isLoading: true,
          printContract: printContract.value!,
          ownRole: ownParticipant.role,
          otherUser: otherUser.value!,
          communityPrintRequest: communityPrintRequest.value!,
          payment: payment.value!,
          paymentMethod: paymentMethod.value!,
          paymentAttributes: paymentAttributes.value!,
          paymentValues: paymentValues.value!,
          ownUser: ownUser.value!,
          item: item.value!,
          itemImages: imageResult.value!,
        ),
      ),
    );
    // get construction file
    ConstructionFile? constructionFile;
    if (item.value!.constructionFileId != null) {
      var constructionFileResult = await constructionFileService
          .getConstructionFile(item.value!.constructionFileId!);
      if (!constructionFileResult.isSuccessful) {
        emit(PrintContractFailed(constructionFileResult.failure!));
        return;
      }
      constructionFile = constructionFileResult.value!;
      emit(
        PrintContractLoaded(
          PrintContractViewModel(
            isLoading: true,
            printContract: printContract.value!,
            ownRole: ownParticipant.role,
            otherUser: otherUser.value!,
            communityPrintRequest: communityPrintRequest.value!,
            payment: payment.value!,
            paymentMethod: paymentMethod.value!,
            paymentAttributes: paymentAttributes.value!,
            paymentValues: paymentValues.value!,
            ownUser: ownUser.value!,
            item: item.value!,
            itemImages: imageResult.value!,
            constructionFile: constructionFile,
          ),
        ),
      );
    }

    // no need in address when contractStatus == pending
    if (printContract.value!.contractStatus == PrintContractStatus.pending) {
      emit(
        PrintContractLoaded(
          PrintContractViewModel(
            isLoading: false,
            printContract: printContract.value!,
            ownRole: ownParticipant.role,
            otherUser: otherUser.value!,
            communityPrintRequest: communityPrintRequest.value!,
            payment: payment.value!,
            paymentMethod: paymentMethod.value!,
            paymentAttributes: paymentAttributes.value!,
            paymentValues: paymentValues.value!,
            ownUser: ownUser.value!,
            item: item.value!,
            itemImages: imageResult.value!,
            constructionFile: constructionFile,
          ),
        ),
      );
      return;
    }
    // get address
    // if print contract has address: get it
    if (printContract.value!.revealedAddressId != null) {
      var address = await addressService.getAddress(
        printContract.value!.revealedAddressId!,
      );
      if (!address.isSuccessful) {
        emit(PrintContractFailed(address.failure!));
        return;
      }
      emit(
        PrintContractLoaded(
          PrintContractViewModel(
            isLoading: false,
            printContract: printContract.value!,
            ownRole: ownParticipant.role,
            otherUser: otherUser.value!,
            communityPrintRequest: communityPrintRequest.value!,
            payment: payment.value!,
            paymentMethod: paymentMethod.value!,
            paymentAttributes: paymentAttributes.value!,
            paymentValues: paymentValues.value!,
            address: address.value!,
            ownUser: ownUser.value!,
            item: item.value!,
            itemImages: imageResult.value!,
            constructionFile: constructionFile,
          ),
        ),
      );
      return;
    }
    // if current user is helpreceiver: get own address
    if (ownParticipant.role == ParticipantRole.helpReceiver) {
      var address = await addressService.getAddressByUserId(ownUser.value!.id!);
      if (!address.isSuccessful) {
        emit(PrintContractFailed(address.failure!));
        return;
      }
      emit(
        PrintContractLoaded(
          PrintContractViewModel(
            isLoading: false,
            printContract: printContract.value!,
            ownRole: ownParticipant.role,
            otherUser: otherUser.value!,
            communityPrintRequest: communityPrintRequest.value!,
            payment: payment.value!,
            paymentMethod: paymentMethod.value!,
            paymentAttributes: paymentAttributes.value!,
            paymentValues: paymentValues.value!,
            address: address.value!,
            ownUser: ownUser.value!,
            item: item.value!,
            itemImages: imageResult.value!,
            constructionFile: constructionFile,
          ),
        ),
      );
      return;
    }
  }
}
