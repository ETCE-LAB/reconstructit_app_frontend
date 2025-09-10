import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:reconstructitapp/components/AppButton.dart';
import 'package:reconstructitapp/components/AppSecondaryButton.dart';
import 'package:reconstructitapp/components/AppTextField.dart';
import 'package:reconstructitapp/domain/entity_models/enums/repair_status.dart';
import 'package:reconstructitapp/presentation/create_or_edit_request/local_components/image_container.dart';
import 'package:reconstructitapp/presentation/your_requests/your_requests_body_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entity_models/enums/print_material.dart';
import '../camera/camera_screen.dart';
import '../camera/image_view_screen.dart';

class CreateOrEditRequestBody extends StatefulWidget {
  final YourRequestsBodyViewModel? requestsBodyViewModel;
  final void Function(
    List<String> images,
    String title,
    String description,
    PrintMaterial? printMaterial,
    String modelFilePath,
  )?
  onSubmitCreate;
  final void Function(
    YourRequestsBodyViewModel yourRequestsBodyViewModel,
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

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  File? modelFile;
  PrintMaterial? selectedPrintMaterial;
  List<String> images = [];
  late TextEditingController materialController;

  @override
  void initState() {
    print(widget.requestsBodyViewModel?.communityPrintRequest.toString());
    super.initState();
    print(widget.requestsBodyViewModel?.communityPrintRequest?.printMaterial);
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

    descriptionController = TextEditingController(text: description);
    titleController = TextEditingController(text: title);
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
                      if (widget.requestsBodyViewModel != null)
                        Text(
                          "letzte Änderung: ",
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      if (widget.requestsBodyViewModel != null)
                        AppSecondaryButton(
                          child: Row(
                            children: [
                              Icon(Icons.arrow_circle_down),
                              SizedBox(width: 10),
                              Text("Herunterladen"),
                            ],
                          ),
                          onPressed: () async {
                            if (widget
                                    .requestsBodyViewModel
                                    ?.constructionFile
                                    ?.fileUrl !=
                                null) {
                              await launchUrl(
                                Uri.parse(
                                  widget
                                      .requestsBodyViewModel!
                                      .constructionFile!
                                      .fileUrl,
                                ),
                              );
                            }
                          },
                        ),
                      AppSecondaryButton(
                        child: Row(
                          children: [
                            Icon(Icons.arrow_circle_up),
                            SizedBox(width: 10),
                            Text(
                              widget.requestsBodyViewModel != null
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
                            modelFile = File(result.files.single.path!);
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
                        if (states.contains(MaterialState.selected)) {
                          return Icon(Icons.check);
                        }
                        //return Colors.grey;
                      }),
                    ),

                    Flexible(
                      child: Column(
                        children: [
                          Text(
                            "Frag die Community, ob sie dir beim Erstellen deines Gegenstandes aus der Konstruktionsdatei hilft",
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
                                  color: Colors.grey ?? Colors.transparent,
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
                              "Laut unseren Berechnungen musst du $price€ dafür zahlen, dass jemand dir das Ersatzteil druckt.",
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
                  widget.onSubmitCreate != null
                      ? AppButton(
                        child: Text("Inserieren und CAD generieren"),
                        onPressed: () {
                          widget.onSubmitCreate!(
                            images,
                            titleController.text,
                            descriptionController.text,
                            hasRequest == true ? selectedPrintMaterial : null,
                            modelFile!.path,
                          );
                        },
                      )
                      : AppButton(
                        child: Text("Änderungen speichern"),
                        onPressed: () {
                          widget.onSubmitEdit!(
                            widget.requestsBodyViewModel!,
                            titleController.text,
                            descriptionController.text,
                            repaired,
                            images,

                            hasRequest == true ? selectedPrintMaterial : null,
                            hasRequest,
                          );
                        },
                      ),
                ],
              ),
              Container(height: 15),
            ],
          ),
        ],
      ),
    );
  }
}
