import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/domain/services/user_service.dart';

import 'home_event.dart';
import 'home_state.dart';

/// Handles Tab changes in navbar and checks if the profile exists
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserService userService;

  HomeBloc(this.userService) : super(HomeIdle()) {
    on<HomePageChanged>(_onPageChanged);
    on<CheckIfProfileExists>(_onCheckUser);
  }

  void _onPageChanged(HomePageChanged event, emit) {
    emit(HomeLoaded(event.tab));
  }

  void _onCheckUser(CheckIfProfileExists event, emit) async {
    emit(HomeLoading());
    var userResult = await userService.getCurrentUser();
    if (!userResult.isSuccessful) {
      emit(HomeFailed());
      return;
    }
    if (userResult.value == null) {
      emit(UserDoesNotExists());
    } else {
      emit(HomeLoaded(1));
    }
  }
}
