import 'package:reconstructitapp/presentation/your_items/your_items_body_view_model.dart';

import '../../../domain/entity_models/enums/print_material.dart';

class CreateOrEditRequestEvent {}

class CreateRequest extends CreateOrEditRequestEvent {
  final List<String> images;
  final String title;
  final String description;
  final PrintMaterial? printMaterial;
  final String modelFilePath;

  CreateRequest(
    this.images,
    this.title,
    this.description,
    this.printMaterial,
    this.modelFilePath,
  );
}

class EditRequest extends CreateOrEditRequestEvent {
  final YourItemsBodyViewModel yourRequestsBodyViewModel;
  final String title;
  final String description;
  final bool repaired;
  final List<String> images;
  final PrintMaterial? printMaterial;
  final bool withRequest;

  EditRequest(
    this.title,
    this.description,
    this.repaired,
    this.images,
    this.printMaterial,
    this.withRequest,
    this.yourRequestsBodyViewModel,
  );
}
