import '../your_items_body_view_model.dart';

abstract class YourItemsState {}

class YourItemsInitial extends YourItemsState {}

class YourItemsLoading extends YourItemsState {}

class YourItemsLoaded extends YourItemsState {
  final List<YourItemsBodyViewModel> yourRequestsBodyViewModel;

  YourItemsLoaded(this.yourRequestsBodyViewModel);
}

class YourItemsFailed extends YourItemsState {
  final Exception exception;

  YourItemsFailed(this.exception);
}
