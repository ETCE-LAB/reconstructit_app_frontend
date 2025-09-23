import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/domain/services/community_print_request_service.dart';
import 'package:reconstructitapp/domain/services/item_image_service.dart';
import 'package:reconstructitapp/domain/services/item_service.dart';
import 'package:reconstructitapp/domain/services/user_service.dart';
import 'package:reconstructitapp/presentation/community/community_body_view_model.dart';

import 'community_event.dart';
import 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  final UserService userService;
  final ItemService itemService;
  final ItemImageService itemImageService;
  final CommunityPrintRequestService communityPrintRequestService;

  CommunityBloc(
    this.itemService,
    this.itemImageService,
    this.communityPrintRequestService,
    //this.chatService,
    this.userService,
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

      // if not the item from the current user, break
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
      );

      emit(CommunityLoaded(viewModels));
    }
    emit(CommunityLoaded(viewModels));
  }
}
