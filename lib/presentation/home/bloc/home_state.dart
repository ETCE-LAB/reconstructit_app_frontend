abstract class HomeState {}

class HomeIdle extends HomeState {
  final int selectedPage;

  HomeIdle(this.selectedPage);
}
