import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/domain/services/user_service.dart';
import 'user_event.dart';
import 'user_state.dart';


class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService userService;

  UserBloc( this.userService)
      : super( UserInitial()) {
    on<Refresh>(_onRefresh);
  }

  void _onRefresh(event, emit) async {
    print("====== refresh");
    emit(UserLoading());
    var userResult = await userService.getCurrentUser();
    print(userResult);
    if (userResult.isSuccessful) {
      if(userResult.value != null){
        print(userResult.value?.toJson());
        emit(UserLoaded(userResult.value!));
      } else{
        emit(UserNotExisting());
      }
    } else {
      emit(UserFailed(userResult.failure!));
    }


  }
}
