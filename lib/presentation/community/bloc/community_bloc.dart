import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/domain/entity_models/enums/print_contract_status.dart';
import 'package:reconstructitapp/domain/services/community_print_request_service.dart';
import 'package:reconstructitapp/domain/services/construction_file_service.dart';
import 'package:reconstructitapp/domain/services/item_image_service.dart';
import 'package:reconstructitapp/domain/services/item_service.dart';
import 'package:reconstructitapp/domain/services/print_contract_service.dart';
import 'package:reconstructitapp/domain/services/user_service.dart';
import 'package:reconstructitapp/presentation/community/community_body_view_model.dart';

import 'community_event.dart';
import 'community_state.dart';

/// Bloc to get CommunityPrintRequests that are not from the logged in user
/// and not accepted requests
class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  final UserService userService;
  final ItemService itemService;
  final ItemImageService itemImageService;
  final CommunityPrintRequestService communityPrintRequestService;
  final ConstructionFileService constructionFileService;
  final PrintContractService printContractService;

  CommunityBloc(
    this.itemService,
    this.itemImageService,
    this.communityPrintRequestService,
    this.userService,
    this.constructionFileService,
    this.printContractService,
  ) : super(CommunityInitial()) {
    on<CommunityRefresh>(_onRefresh);
  }

  void _onRefresh(event, emit) async {
    emit(CommunityLoading());
    // get user because there should not be own entries in the feed
    var userResult = await userService.getCurrentUser();
    if (!userResult.isSuccessful) {
      emit(CommunityFailed(userResult.failure!));
      return;
    }
    // get all community print requests
    var requestResult =
        await communityPrintRequestService.getAllCommunityPrintRequests();
    if (!requestResult.isSuccessful) {
      emit(CommunityFailed(requestResult.failure!));
      return;
    }
    // initialize list to emit
    List<CommunityBodyViewModel> viewModels = [];
    // break out count to eliminate own or accepted requests
    int breakOutCount = 0;
    for (int i = 0; i < requestResult.value!.length; i++) {
      // get the item to every request
      var itemsResult = await itemService.getItem(
        requestResult.value![i].itemId,
      );
      if (!itemsResult.isSuccessful) {
        emit(CommunityFailed(itemsResult.failure!));
        return;
      }

      var printContracts = await printContractService.getContractsForRequest(
        requestResult.value![i].id!,
      );
      // if there is already an accepted contract, skip this
      if (printContracts.value!.any(
        (contract) =>
            contract.contractStatus == PrintContractStatus.done ||
            contract.contractStatus == PrintContractStatus.printed ||
            contract.contractStatus == PrintContractStatus.accepted,
      )) {
        breakOutCount++;
        continue;
      }
      // if the item from the current user, break
      if (itemsResult.value!.userId == userResult.value!.id) {
        breakOutCount++;
        continue;
      }
      // append item and emit state
      viewModels.add(
        CommunityBodyViewModel(
          null,
          requestResult.value![i],
          itemsResult.value!,
          null,
          null,
        ),
      );
      emit(CommunityLoaded(viewModels));
      // get the item image
      var imageResult = await itemImageService.getItemImagesForItem(
        requestResult.value![i].itemId,
      );
      if (!imageResult.isSuccessful) {
        emit(CommunityFailed(imageResult.failure!));
        return;
      }
      viewModels[i - breakOutCount] = CommunityBodyViewModel(
        null,
        requestResult.value![i],
        itemsResult.value!,
        imageResult.value!,
        null,
      );
      emit(CommunityLoaded(viewModels));
      // get the user
      var requestUserResult = await userService.getUser(
        itemsResult.value!.userId,
      );
      if (!requestUserResult.isSuccessful) {
        emit(CommunityFailed(requestUserResult.failure!));
        return;
      }
      viewModels[i - breakOutCount] = CommunityBodyViewModel(
        requestUserResult.value!,
        requestResult.value![i],
        itemsResult.value!,
        imageResult.value!,
        null,
      );

      emit(CommunityLoaded(viewModels));
      // get the construction file
      var fileResult = await constructionFileService.getConstructionFile(
        itemsResult.value!.constructionFileId!,
      );
      if (!fileResult.isSuccessful) {
        emit(CommunityFailed(fileResult.failure!));
        return;
      }
      viewModels[i - breakOutCount] = CommunityBodyViewModel(
        requestUserResult.value!,
        requestResult.value![i],
        itemsResult.value!,
        imageResult.value!,
        fileResult.value!,
      );

      emit(CommunityLoaded(viewModels));
    }
    emit(CommunityLoaded(viewModels));
  }
}
