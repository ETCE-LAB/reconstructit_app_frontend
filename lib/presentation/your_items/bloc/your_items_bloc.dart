import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/domain/services/community_print_request_service.dart';
import 'package:reconstructitapp/domain/services/construction_file_service.dart';
import 'package:reconstructitapp/domain/services/item_image_service.dart';
import 'package:reconstructitapp/domain/services/item_service.dart';
import 'package:reconstructitapp/domain/services/user_service.dart';

import '../your_items_body_view_model.dart';
import 'your_items_event.dart';
import 'yout_items_state.dart';

/// Bloc to load own items
class YourItemsBloc extends Bloc<YourItemsEvent, YourItemsState> {
  final UserService userService;
  final ItemService itemService;
  final ItemImageService itemImageService;
  final CommunityPrintRequestService communityPrintRequestService;
  final ConstructionFileService constructionFileService;

  YourItemsBloc(
    this.itemService,
    this.itemImageService,
    this.communityPrintRequestService,
    this.userService,
    this.constructionFileService,
  ) : super(YourItemsInitial()) {
    on<RefreshItems>(_onRefresh);
  }

  void _onRefresh(event, emit) async {
    emit(YourItemsLoading());
    var userResult = await userService.getCurrentUser();
    if (!userResult.isSuccessful) {
      emit(YourItemsFailed(userResult.failure!));
      return;
    }
    // get all items
    var itemsResult = await itemService.getItemsForUserId(
      userResult.value!.id!,
    );
    if (!itemsResult.isSuccessful) {
      emit(YourItemsFailed(itemsResult.failure!));
      return;
    }
    // list of view models
    final viewModels =
        itemsResult.value!
            .map((item) => YourItemsBodyViewModel(null, item, null, null))
            .toList();
    emit(YourItemsLoaded(viewModels));

    // get itemImages
    for (int i = 0; i < viewModels.length; i++) {
      final item = viewModels[i].item;
      var itemImagesResult = await itemImageService.getItemImagesForItem(
        item.id!,
      );
      if (!itemImagesResult.isSuccessful) {
        emit(YourItemsFailed(itemImagesResult.failure!));
        return;
      }

      var updatedViewModel = YourItemsBodyViewModel(
        null,
        item,
        itemImagesResult.value!,
        null,
      );
      viewModels[i] = updatedViewModel;
      emit(YourItemsLoaded(viewModels));
      // get community print request
      if (item.communityPrintRequestId != null) {
        var communityRequestResult = await communityPrintRequestService
            .getCommunityPrintRequest(item.communityPrintRequestId!);
        if (!communityRequestResult.isSuccessful) {
          emit(YourItemsFailed(communityRequestResult.failure!));
          return;
        }
        updatedViewModel = YourItemsBodyViewModel(
          communityRequestResult.value!,
          item,
          itemImagesResult.value!,
          null,
        );
        viewModels[i] = updatedViewModel;
        emit(YourItemsLoaded(viewModels));
      }
      // get construction file
      if (item.constructionFileId != null) {
        var constructionFileResult = await constructionFileService
            .getConstructionFile(item.constructionFileId!);
        if (!constructionFileResult.isSuccessful) {
          emit(YourItemsFailed(constructionFileResult.failure!));
          return;
        }
        updatedViewModel = YourItemsBodyViewModel(
          viewModels[i].communityPrintRequest,
          item,
          itemImagesResult.value!,
          constructionFileResult.value!,
        );
        viewModels[i] = updatedViewModel;
        emit(YourItemsLoaded(viewModels));
      }
    }
  }
}
