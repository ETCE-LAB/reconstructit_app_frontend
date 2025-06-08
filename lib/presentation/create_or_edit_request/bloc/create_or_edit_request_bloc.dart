import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/domain/entity_models/community_print_request.dart';
import 'package:reconstructitapp/domain/entity_models/enums/repair_status.dart';
import 'package:reconstructitapp/domain/entity_models/item.dart';
import 'package:reconstructitapp/domain/entity_models/item_image.dart';
import 'package:reconstructitapp/domain/services/community_print_request_service.dart';
import 'package:reconstructitapp/domain/services/item_image_service.dart';
import 'package:reconstructitapp/domain/services/item_service.dart';
import 'package:reconstructitapp/domain/services/media_service.dart';
import 'package:reconstructitapp/domain/services/user_service.dart';

import 'create_or_edit_request_event.dart';
import 'create_or_edit_request_state.dart';

class CreateOrEditRequestBloc
    extends Bloc<CreateOrEditRequestEvent, CreateOrEditRequestState> {
  final UserService userService;
  final ItemService itemService;
  final ItemImageService itemImageService;
  final CommunityPrintRequestService communityPrintRequestService;
  final MediaService mediaService;

  CreateOrEditRequestBloc(
    this.itemService,
    this.itemImageService,
    this.communityPrintRequestService,
    this.userService,
    this.mediaService,
  ) : super(CreateOrEditRequestInitial()) {
    on<CreateRequest>(_onCreate);
    on<EditRequest>(_onEdit);
  }

  void _onCreate(CreateRequest event, emit) async {
    print(event.title);
    print(event.description);
    print(event.priceMax);
    print(event.images);
    emit(CreateOrEditRequestLoading());
    // get user id
    var userResult = await userService.getCurrentUser();
    if (!userResult.isSuccessful) {
      emit(CreateOrEditRequestFailed(userResult.failure!));
      return;
    }
    // create item
    var itemResult = await itemService.createItem(
      Item(
        null,
        RepairStatus.broken,
        event.title,
        event.description,
        null,
        userResult.value!.id!,
        null,
      ),
    );
    if (!itemResult.isSuccessful) {
      emit(CreateOrEditRequestFailed(itemResult.failure!));
      return;
    }
    // upload media an create item image
    for (int i = 0; i < event.images.length; i++) {
      final imageFile = event.images[i];
      var mediaResult = await mediaService.postImage(File(imageFile));
      if (!mediaResult.isSuccessful) {
        emit(CreateOrEditRequestFailed(mediaResult.failure!));
        return;
      }
      // create item image
      var itemImageResult = await itemImageService.createItemImage(
        ItemImage(null, mediaResult.value!, itemResult.value!.id!),
      );
      if (!itemImageResult.isSuccessful) {
        print("not succesful");
        print(itemImageResult.failure);

        emit(CreateOrEditRequestFailed(itemImageResult.failure!));
        return;
      }
    }
    // create request if needed
    if (event.priceMax != null) {
      var requestResult = await communityPrintRequestService
          .createCommunityPrintRequest(
            CommunityPrintRequest(null, event.priceMax!, itemResult.value!.id!),
          );
      if (!requestResult.isSuccessful) {
        emit(CreateOrEditRequestFailed(requestResult.failure!));
        return;
      }
    }
    emit(CreateOrEditRequestSucceeded());
  }

  void _onEdit(EditRequest event, emit) async {
    emit(CreateOrEditRequestLoading());
    // changes in item
    var editItemResult = await itemService.updateItem(
      Item(
        event.yourRequestsBodyViewModel.item.id!,
        event.repaired ? RepairStatus.fixed : RepairStatus.broken,
        event.title,
        event.description,
        event.yourRequestsBodyViewModel.item.constructionFileId,
        event.yourRequestsBodyViewModel.item.userId,
        event.yourRequestsBodyViewModel.item.communityPrintRequestId,
      ),
    );
    if (!editItemResult.isSuccessful) {
      emit(CreateOrEditRequestFailed(editItemResult.failure!));
      return;
    }
    // changes in community print request
    // 1. delete request
    if (event.yourRequestsBodyViewModel.communityPrintRequest != null &&
        event.withRequest == false) {
      var deleteRequestResult = await communityPrintRequestService
          .deleteCommunityPrintRequest(
            event.yourRequestsBodyViewModel.communityPrintRequest!.id!,
          );
      if (!deleteRequestResult.isSuccessful) {
        emit(CreateOrEditRequestFailed(deleteRequestResult.failure!));
        return;
      }
    }
    // 2. edit request
    if (event.yourRequestsBodyViewModel.communityPrintRequest != null &&
        event.withRequest == true &&
        event.priceMax !=
            event.yourRequestsBodyViewModel.communityPrintRequest!.priceMax) {
      var editRequestResult = await communityPrintRequestService
          .updateCommunityPrintRequest(
            CommunityPrintRequest(
              event.yourRequestsBodyViewModel.communityPrintRequest!.id!,
              event.priceMax!,
              event.yourRequestsBodyViewModel.communityPrintRequest!.itemId,
            ),
          );
      if (!editRequestResult.isSuccessful) {
        emit(CreateOrEditRequestFailed(editRequestResult.failure!));
        return;
      }
    }
    // 3. create request
    if (event.yourRequestsBodyViewModel.communityPrintRequest == null &&
        event.withRequest == true &&
        event.priceMax != null) {
      print("in create request");
      var createRequestResult = await communityPrintRequestService
          .createCommunityPrintRequest(
            CommunityPrintRequest(
              null,
              event.priceMax!,
              event.yourRequestsBodyViewModel.item.id!,
            ),
          );
      if (!createRequestResult.isSuccessful) {
        print("error in create");
        print(createRequestResult.failure!);
        emit(CreateOrEditRequestFailed(createRequestResult.failure!));
        return;
      }
    }
    // changes in item images
    // 1. delete images
    final imagesToDelete =
        event.yourRequestsBodyViewModel.images!
            .where((itemImage) => !event.images.contains(itemImage.imageUrl))
            .toList();
    for (var image in imagesToDelete) {
      var deleteImageResult = await itemImageService.deleteItemImage(image.id!);
      if (!deleteImageResult.isSuccessful) {
        emit(CreateOrEditRequestFailed(deleteImageResult.failure!));
        return;
      }
    }
    // 2. create images
    final existingUrls =
        event.yourRequestsBodyViewModel.images!.map((e) => e.imageUrl).toSet();
    final imagesToCreate =
        event.images.where((url) => !existingUrls.contains(url)).toList();

    for (var imageFile in imagesToCreate) {
      var mediaResult = await mediaService.postImage(File(imageFile));
      if (!mediaResult.isSuccessful) {
        emit(CreateOrEditRequestFailed(mediaResult.failure!));
        return;
      }
      // create item image
      var itemImageResult = await itemImageService.createItemImage(
        ItemImage(
          null,
          mediaResult.value!,
          event.yourRequestsBodyViewModel.item.id!,
        ),
      );
      if (!itemImageResult.isSuccessful) {
        emit(CreateOrEditRequestFailed(itemImageResult.failure!));
        return;
      }
    }
    emit(CreateOrEditRequestSucceeded());
  }
}
