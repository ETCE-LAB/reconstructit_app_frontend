abstract class HomeEvent {}

class HomePageChanged extends HomeEvent {
  final int tab;

  HomePageChanged(this.tab);
}
class HomeChatNotificationOpened extends HomeEvent{

}