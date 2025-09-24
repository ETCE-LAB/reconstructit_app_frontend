import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:reconstructitapp/components/app_button.dart';
import 'package:reconstructitapp/components/app_secondary_button.dart';
import 'package:reconstructitapp/components/app_text_field.dart';
import 'package:reconstructitapp/domain/entity_models/enums/repair_status.dart';
import 'package:reconstructitapp/presentation/create_or_edit_request/local_components/image_container.dart';
import 'package:reconstructitapp/presentation/your_items/your_items_body_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entity_models/enums/print_material.dart';
import '../camera/camera_screen.dart';
import '../camera/image_view_screen.dart';
import 'bloc/create_or_edit_request_bloc.dart';
import 'bloc/create_or_edit_request_state.dart';

/// Used to create and/or edit a request
class CreateOrEditRequestBody extends StatefulWidget {
  final YourItemsBodyViewModel? requestsBodyViewModel;
  final void Function(
    List<String> images,
    String title,
    String description,
    PrintMaterial? printMaterial,
    String modelFilePath,
  )?
  onSubmitCreate;
  final void Function(
      YourItemsBodyViewModel yourRequestsBodyViewModel,
    String title,
    String description,
    bool repaired,
    List<String> images,
    PrintMaterial? printMaterial,
    bool withRequest,
  )?
  onSubmitEdit;

  const CreateOrEditRequestBody({
    super.key,
    required this.requestsBodyViewModel,
    this.onSubmitCreate,
    this.onSubmitEdit,
  });

  @override
  State<CreateOrEditRequestBody> createState() =>
      _CreateOrEditRequestBodyState();
}

class _CreateOrEditRequestBodyState extends State<CreateOrEditRequestBody> {
  late bool repaired;
  late String? title;
  late String? description;
  late bool hasRequest;
  late double? price;
  DateTime? createdAt;

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  String? filePath;

  PrintMaterial? selectedPrintMaterial;
  List<String> images = [];
  late TextEditingController materialController;

  @override
  void initState() {
    super.initState();
    selectedPrintMaterial =
        widget.requestsBodyViewModel?.communityPrintRequest?.printMaterial;

    // materialController = TextEditingController(text:selectedPrintMaterial.toString() );
    images =
        widget.requestsBodyViewModel != null &&
                widget.requestsBodyViewModel!.images != null
            ? widget.requestsBodyViewModel!.images!
                .map((itemImage) => itemImage.imageUrl)
                .toList()
            : [];
    repaired = widget.requestsBodyViewModel?.item.status == RepairStatus.fixed;
    title = widget.requestsBodyViewModel?.item.title;
    description = widget.requestsBodyViewModel?.item.description;
    hasRequest = widget.requestsBodyViewModel?.communityPrintRequest != null;
    price = widget.requestsBodyViewModel?.communityPrintRequest?.priceMax;

    filePath = widget.requestsBodyViewModel?.constructionFile?.fileUrl;

    descriptionController = TextEditingController(text: description);
    titleController = TextEditingController(text: title);
    createdAt = widget.requestsBodyViewModel?.constructionFile?.createdAt;

    titleController.addListener(() => setState(() {}));
    descriptionController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              spacing: 10.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Row(
                      children:
                          List.generate(
                            images.length,
                            (index) => ImageContainer(
                              imagePath: images[index],
                              onRemove: () {
                                setState(() {
                                  images.removeAt(index - 1);
                                });
                              },
                            ),
                          ).toList(),
                    ),

                    SizedBox(width: 7),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => CameraScreen(
                                  toNextScreenWithImage: (imagePath) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => ImageViewScreen(
                                              imagePath: imagePath,
                                              toNextScreenWithImage: () {
                                                setState(() {
                                                  images.add(imagePath);
                                                });

                                                Navigator.pop(context);
                                                Navigator.pop(context);

                                                //_setNewLocal();
                                              },
                                              retakeImage: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                      ),
                                    );
                                  },
                                ),
                          ),
                        );
                      },

                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            size: 50,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (widget.requestsBodyViewModel != null)
                  Row(
                    children: [
                      Checkbox(
                        value: repaired,
                        onChanged: (bool? isChecked) {
                          setState(() {
                            repaired = isChecked!;
                          });
                        },
                      ),
                      Text(
                        "Repariert",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),

                AppTextField(hint: "Titel", controller: titleController),
                AppTextField(
                  hint: "Beschreibung",
                  controller: descriptionController,
                  minLines: 3,
                  maxLines: 10,
                ),

                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "3D Drucker Modell verwalten",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      if (createdAt != null)
                        Text(
                          "letzte Änderung: ${DateFormat('dd.MM.yyyy HH:mm').format(createdAt!)}",
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      if (filePath != null)
                        AppSecondaryButton(
                          onPressed: () async {
                            if (filePath!.startsWith("http") ||
                                filePath!.startsWith("https")) {
                              await launchUrl(
                                Uri.parse(filePath!),
                                mode: LaunchMode.externalApplication,
                              );
                            } else {
                              await OpenFile.open(filePath);
                            }
                          },
                          child: Row(
                            children: [
                              Icon(Icons.arrow_circle_down),
                              SizedBox(width: 10),
                              Text("Herunterladen"),
                            ],
                          ),
                        ),
                      AppSecondaryButton(
                        child: Row(
                          children: [
                            Icon(Icons.arrow_circle_up),
                            SizedBox(width: 10),
                            Text(
                              filePath != null
                                  ? "Andere Datei hochladen"
                                  : "Modell hochladen",
                            ),
                          ],
                        ),
                        onPressed: () async {
                          final result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['stl'],
                          );

                          if (result != null &&
                              result.files.single.path != null) {
                            setState(() {
                              filePath = result.files.single.path!;
                              createdAt = DateTime.now();
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  spacing: 10.0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Switch(
                      value: hasRequest,
                      onChanged: (bool? withRequest) {
                        setState(() {
                          hasRequest = withRequest!;
                        });
                      },
                      thumbIcon: WidgetStateProperty.resolveWith<Icon?>((
                        Set<WidgetState> states,
                      ) {
                        if (states.contains(WidgetState.selected)) {
                          return Icon(Icons.check);
                        }
                        return null;
                      }),
                    ),

                    Flexible(
                      child: Column(
                        children: [
                          Text(
                            "Frag die Community, ob sie dir beim Erstellen deines Gegenstandes aus der Modelldatei hilft",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),

                          DropdownMenu<PrintMaterial>(
                            initialSelection: selectedPrintMaterial,
                            onSelected: (PrintMaterial? printMaterial) {
                              setState(() {
                                selectedPrintMaterial = printMaterial;
                              });
                            },
                            menuStyle: MenuStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Theme.of(context).colorScheme.surfaceContainer,
                              ),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              elevation: WidgetStatePropertyAll(4),
                              shadowColor: WidgetStatePropertyAll(
                                Colors.black45,
                              ),
                            ),
                            inputDecorationTheme: InputDecorationTheme(
                              focusColor: Theme.of(context).colorScheme.primary,
                              filled: true,
                              fillColor:
                                  Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainer,
                              contentPadding: EdgeInsets.all(16),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2.5,
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2.5,
                                  color: Theme.of(context).primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            hintText: "Wähle dein Material",
                            width: double.infinity,
                            dropdownMenuEntries: [
                              DropdownMenuEntry(
                                style:
                                    Theme.of(context).filledButtonTheme.style,
                                value: PrintMaterial.cpe,
                                label: 'CPE',
                              ),
                              DropdownMenuEntry(
                                style:
                                    Theme.of(context).filledButtonTheme.style,
                                value: PrintMaterial.pla,
                                label: 'PLA',
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          if (price != null)
                            Text(
                              "Laut unseren Berechnungen musst du ${price!.toStringAsFixed(2)}€ dafür zahlen, dass jemand dir das Ersatzteil druckt.",
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<
                    CreateOrEditRequestBloc,
                    CreateOrEditRequestState
                  >(
                    builder: (context, state) {
                      final isLoading = state is CreateOrEditRequestLoading;

                      return AppButton(
                        onPressed:
                            !_isFormValid || isLoading
                                ? null
                                : widget.onSubmitCreate != null
                                ? () {
                                  widget.onSubmitCreate!(
                                    images,
                                    titleController.text,
                                    descriptionController.text,
                                    hasRequest == true
                                        ? selectedPrintMaterial
                                        : null,
                                    filePath!,
                                  );
                                }
                                : () {
                                  widget.onSubmitEdit!(
                                    widget.requestsBodyViewModel!,
                                    titleController.text,
                                    descriptionController.text,
                                    repaired,
                                    images,
                                    hasRequest == true
                                        ? selectedPrintMaterial
                                        : null,
                                    hasRequest,
                                  );
                                },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isLoading) ...[
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                widget.onSubmitCreate != null
                                    ? "Erstellen..."
                                    : "Speichern...",
                              ),
                            ] else ...[
                              Text(
                                widget.onSubmitCreate != null
                                    ? "Erstellen"
                                    : "Änderungen speichern",
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool get _isFormValid {
    // min one image
    final hasImage = images.isNotEmpty;

    // title and description is set
    final hasTitle = titleController.text.trim().isNotEmpty;
    final hasDescription = descriptionController.text.trim().isNotEmpty;

    // material must be set if has request is true
    final hasMaterialIfRequested = !hasRequest || selectedPrintMaterial != null;

    // Model File should exists
    final hasModelFile = filePath != null;

    return hasImage &&
        hasTitle &&
        hasDescription &&
        hasMaterialIfRequested &&
        hasModelFile;
  }
}
