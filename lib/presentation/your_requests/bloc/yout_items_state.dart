import 'package:reconstructitapp/presentation/your_requests/your_requests_body_view_model.dart';

abstract class YourItemsState {}

class YourItemsInitial extends YourItemsState {}

class YourItemsLoading extends YourItemsState {}

class YourItemsLoaded extends YourItemsState {
  final List<YourRequestsBodyViewModel> yourRequestsBodyViewModel;

  YourItemsLoaded(this.yourRequestsBodyViewModel);
}

class YourItemsFailed extends YourItemsState {
  final Exception exception;

  YourItemsFailed(this.exception);
}
