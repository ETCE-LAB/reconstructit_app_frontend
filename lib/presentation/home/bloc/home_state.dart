abstract class HomeState {}

class HomeIdle extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final int selectedPage;

  HomeLoaded(this.selectedPage);
}

class UserDoesNotExists extends HomeState {}

class HomeFailed extends HomeState {}
