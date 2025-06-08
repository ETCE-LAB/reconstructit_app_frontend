import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(HomeIdle(3)) {
    on<HomePageChanged>(_onPageChanged);
    on<HomeChatNotificationOpened>(_onNotificationOpened);
  }

  void _onPageChanged(HomePageChanged event, emit) {
    emit(HomeIdle(event.tab));
  }

  void _onNotificationOpened(HomeChatNotificationOpened event, emit) {
    emit(HomeIdle(1));
  }
}
