import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/domain/services/address_service.dart';
import 'package:reconstructitapp/domain/services/user_service.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;
  final AddressService addressService;

  UserBloc(this.userService, this.addressService) : super(UserInitial()) {
    on<Refresh>(_onRefresh);
  }

  void _onRefresh(event, emit) async {
    emit(UserLoading());
    var userResult = await userService.getCurrentUser();
    print(userResult);
    if (userResult.isSuccessful) {
      if (userResult.value != null) {
        print(userResult.value?.toJson());
        if (userResult.value!.addressId != null) {
          var addressResult = await addressService.getAddress(
            userResult.value!.addressId!,
          );
          if (addressResult.isSuccessful) {
            emit(UserLoaded(userResult.value!, addressResult.value!));
          } else {
            emit(UserFailed(addressResult.failure!));
          }
        } else {
          emit(UserLoaded(userResult.value!, null));
        }
      } else {
        emit(UserNotExisting());
      }
    } else {
      emit(UserFailed(userResult.failure!));
    }
  }
}
