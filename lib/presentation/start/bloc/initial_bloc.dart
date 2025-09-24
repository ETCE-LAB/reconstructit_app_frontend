import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/keys.dart';
import 'initial_event.dart';
import 'initial_state.dart';

/// Bloc to check if the app was already started/ save that it is already started
class InitialBloc extends Bloc<InitialEvent, InitialState> {
  InitialBloc() : super(InitialInitial()) {
    on<AlreadyInitialedRequested>(_onRequested);
    on<FinishedIntroduction>(_onFinishedIntroduction);
  }

  void _onRequested(AlreadyInitialedRequested event, emit) async {
    emit(InitialLoading());
    final prefs = await SharedPreferences.getInstance();
    bool alreadySelected = prefs.getBool(Keys.isAlreadyStarted) ?? false;
    emit(InitialLoaded(alreadySelected));
  }

  void _onFinishedIntroduction(FinishedIntroduction event, emit) async {
    emit(InitialLoading());
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Keys.isAlreadyStarted, true);
    emit(InitialLoaded(true));
  }
}
