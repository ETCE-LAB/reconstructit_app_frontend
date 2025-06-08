import 'package:reconstructitapp/presentation/your_requests/your_requests_body_view_model.dart';

class CreateOrEditRequestEvent {}

class CreateRequest extends CreateOrEditRequestEvent {
  final List<String> images;
  final String title;
  final String description;
  final double? priceMax;

  CreateRequest(this.images, this.title, this.description, this.priceMax);
}

class EditRequest extends CreateOrEditRequestEvent {
  final YourRequestsBodyViewModel yourRequestsBodyViewModel;
  final String title;
  final String description;
  final bool repaired;
  final List<String> images;
  final double? priceMax;
  final bool withRequest;

  EditRequest(
    this.title,
    this.description,
    this.repaired,
    this.images,
    this.priceMax,
    this.withRequest,
    this.yourRequestsBodyViewModel,
  );
}
