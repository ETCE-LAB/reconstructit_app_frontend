import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/domain/entity_models/enums/participant_role.dart';
import 'package:reconstructitapp/domain/entity_models/enums/payment_status.dart';
import 'package:reconstructitapp/domain/entity_models/enums/print_contract_status.dart';
import 'package:reconstructitapp/domain/entity_models/enums/shipping_status.dart';
import 'package:reconstructitapp/domain/entity_models/participant.dart';
import 'package:reconstructitapp/domain/entity_models/payment.dart';
import 'package:reconstructitapp/domain/entity_models/payment_value.dart';
import 'package:reconstructitapp/domain/services/participant_service.dart';
import 'package:reconstructitapp/domain/services/payment_service.dart';
import 'package:reconstructitapp/domain/services/payment_value_service.dart';
import 'package:reconstructitapp/domain/services/user_service.dart';

import '../../../domain/entity_models/print_contract.dart';
import '../../../domain/services/print_contract_service.dart';
import 'create_print_contract_event.dart';
import 'create_print_contract_state.dart';

class CreatePrintContractBloc
    extends Bloc<CreatePrintContractEvent, CreatePrintContractState> {
  final UserService userService;
  final ParticipantService participantService;
  final PrintContractService printContractService;
  final PaymentService paymentService;
  final PaymentValueService paymentValueService;

  CreatePrintContractBloc(
    this.participantService,
    this.printContractService,
    this.userService,
    this.paymentService,
    this.paymentValueService,
  ) : super(CreatePrintContractInitial()) {
    on<CreatePrintContract>(_onCreatePrintContract);
  }

  void _onCreatePrintContract(CreatePrintContract event, emit) async {
    emit(CreatePrintContractLoading());
    // create printContract
    var printContractResult = await printContractService.createPrintContract(
      PrintContract(
        null,
        PrintContractStatus.pending,
        ShippingStatus.pending,
        null,
        null,
        event.communityPrintRequestId,
      ),
    );
    if (!printContractResult.isSuccessful) {
      emit(CreatePrintContractFailed(printContractResult.failure!));
      return;
    }
    // create both participants
    var otherParticipant = await participantService.createParticipant(
      Participant(
        null,
        ParticipantRole.helpReceiver,
        event.otherUserId,
        printContractResult.value!.id!,
      ),
    );
    if (!otherParticipant.isSuccessful) {
      emit(CreatePrintContractFailed(otherParticipant.failure!));
      return;
    }
    // get own user
    var userResult = await userService.getCurrentUser();
    if (!userResult.isSuccessful || userResult.value == null) {
      emit(CreatePrintContractFailed(userResult.failure!));
      return;
    }
    var ownParticipant = await participantService.createParticipant(
      Participant(
        null,
        ParticipantRole.helpProvider,
        userResult.value!.id,
        printContractResult.value!.id!,
      ),
    );
    if (!ownParticipant.isSuccessful) {
      emit(CreatePrintContractFailed(ownParticipant.failure!));
      return;
    }
    // create payment
    var paymentResult = await paymentService.createPayment(
      Payment(
        null,
        PaymentStatus.pending,
        event.paymentMethodId,
        printContractResult.value!.id!,
      ),
    );
    if (!paymentResult.isSuccessful) {
      emit(CreatePrintContractFailed(paymentResult.failure!));
      return;
    }
    // create paymentValues
    for (int i = 0; i < event.paymentValues.length; i++) {
      var paymentValueResult = await paymentValueService.createPaymentValue(
        PaymentValue(
          null,
          event.paymentValues[i].paymentValue,
          event.paymentValues[i].paymentAttributeId,
          paymentResult.value!.id!,
        ),
      );
      if (!paymentValueResult.isSuccessful) {
        emit(CreatePrintContractFailed(paymentValueResult.failure!));
        return;
      }
    }
    emit(
      CreatePrintContractSucceeded(
        printContractId: printContractResult.value!.id!,
      ),
    );
  }
}
