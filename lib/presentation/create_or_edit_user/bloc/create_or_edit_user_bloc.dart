import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/domain/entity_models/address.dart';
import 'package:reconstructitapp/domain/entity_models/user.dart';
import 'package:reconstructitapp/domain/services/address_service.dart';
import 'package:reconstructitapp/domain/services/media_service.dart';
import 'package:reconstructitapp/domain/services/user_service.dart';

import 'create_or_edit_user_event.dart';
import 'create_or_edit_user_state.dart';

class CreateOrEditUserBloc
    extends Bloc<CreateOrEditUserEvent, CreateOrEditUserState> {
  final UserService userService;
  final AddressService addressService;
  final MediaService mediaService;

  CreateOrEditUserBloc(this.addressService, this.userService, this.mediaService)
    : super(CreateOrEditUserInitial()) {
    on<CreateUser>(_onCreate);
    on<EditUser>(_onEdit);
  }

  void _onCreate(CreateUser event, emit) async {
    emit(CreateOrEditUserLoading());
    // create image
    String? finalImageUrl;
    if (event.profilePicture != null) {
      var mediaResult = await mediaService.postImage(
        File(event.profilePicture!),
      );
      if (!mediaResult.isSuccessful) {
        emit(CreateOrEditUserFailed(mediaResult.failure!));
        return;
      }
      finalImageUrl = mediaResult.value!;
    }

    // create user
    var userResult = await userService.createUser(
      event.fistName,
      event.lastName,
      finalImageUrl,
      event.region,
    );
    if (!userResult.isSuccessful) {
      emit(CreateOrEditUserFailed(userResult.failure!));
      return;
    }
    // create Address
    if (event.streetHouseNumber != null &&
        event.city != null &&
        event.zipCode != null) {
      var addressResult = await addressService.createAddress(
        Address(
          null,
          event.streetHouseNumber!,
          event.city!,
          event.zipCode!,
          event.country!,
          userResult.value!.id!,
        ),
      );
      if (!addressResult.isSuccessful) {
        emit(CreateOrEditUserFailed(addressResult.failure!));
        return;
      }
    }
    emit(CreateOrEditUserSucceeded("Profil erfolgreich erstellt", true));
  }

  void _onEdit(EditUser event, emit) async {
    emit(CreateOrEditUserLoading());
    // create image
    String? finalImageUrl;
    if (event.profilePicture != null) {
      if (event.oldUser.userProfilePictureUrl != event.profilePicture) {
        var mediaResult = await mediaService.postImage(
          File(event.profilePicture!),
        );
        if (!mediaResult.isSuccessful) {
          emit(CreateOrEditUserFailed(mediaResult.failure!));
          return;
        }
        finalImageUrl = mediaResult.value!;
      } else {
        finalImageUrl = event.oldUser.userProfilePictureUrl;
      }
    } else {
      finalImageUrl = null;
    }
    // edit address
    String? addressId = event.oldAddress?.id;
    // 1. create address
    if (event.oldAddress == null &&
        event.streetHouseNumber != null &&
        event.city != null &&
        event.zipCode != null &&
        event.country != null) {
      var addressResult = await addressService.createAddress(
        Address(
          null,
          event.streetHouseNumber!,
          event.city!,
          event.zipCode!,
          event.country!,
          event.oldUser.id!,
        ),
      );
      if (!addressResult.isSuccessful) {
        emit(CreateOrEditUserFailed(addressResult.failure!));
        return;
      }
      addressId = addressResult.value!.id!;
    }
    // 2. edit address
    if (event.oldAddress != null &&
        event.streetHouseNumber != null &&
        event.city != null &&
        event.zipCode != null) {
      var addressResult = await addressService.editAddress(
        Address(
          addressId,
          event.streetHouseNumber!,
          event.city!,
          event.zipCode!,
          event.country!,
          event.oldUser.id!,
        ),
      );
      if (!addressResult.isSuccessful) {
        emit(CreateOrEditUserFailed(addressResult.failure!));
        return;
      }
    }
    // 3. delete address
    if (event.oldAddress != null &&
        event.zipCode == null &&
        event.city == null &&
        event.streetHouseNumber == null) {
      var addressResult = await addressService.deleteAddress(
        event.oldAddress!.id!,
      );
      if (!addressResult.isSuccessful) {
        emit(CreateOrEditUserFailed(addressResult.failure!));
        return;
      }
      addressId = null;
    }

    // edit user
    if (event.firstName != event.oldUser.firstName ||
        event.lastName != event.oldUser.lastName ||
        event.region != event.oldUser.region ||
        event.oldUser.userProfilePictureUrl != finalImageUrl) {
      var userResult = await userService.editUser(
        User(
          event.oldUser.id,
          event.firstName,
          event.lastName,
          event.region,
          finalImageUrl,
          event.oldUser.userAccountId,
        ),
      );
      if (!userResult.isSuccessful) {
        emit(CreateOrEditUserFailed(userResult.failure!));
        return;
      }
    }

    emit(CreateOrEditUserSucceeded("Profil erfolgreich bearbeitet", false));
  }
}
