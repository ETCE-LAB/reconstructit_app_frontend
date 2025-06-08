import 'package:flutter/material.dart';
import 'package:reconstructitapp/components/AppButton.dart';
import 'package:reconstructitapp/components/AppSecondaryButton.dart';
import 'package:reconstructitapp/components/AppTextField.dart';
import 'package:reconstructitapp/domain/entity_models/enums/repair_status.dart';
import 'package:reconstructitapp/presentation/chat/chat_entry.dart';
import 'package:reconstructitapp/presentation/create_or_edit_request/local_components/image_container.dart';
import 'package:reconstructitapp/presentation/your_requests/your_requests_body_view_model.dart';

import '../../domain/entity_models/chat.dart';
import '../../domain/entity_models/community_print_request.dart';
import '../../domain/entity_models/enums/chat_status.dart';
import '../../domain/entity_models/enums/participant_role.dart';
import '../../domain/entity_models/item.dart';
import '../../domain/entity_models/message.dart';
import '../../domain/entity_models/participant.dart';
import '../../domain/entity_models/user.dart';
import '../camera/camera_screen.dart';
import '../camera/image_view_screen.dart';
import '../chat/chat_body_view_model.dart';

class CreateOrEditRequestBody extends StatefulWidget {
  final YourRequestsBodyViewModel? requestsBodyViewModel;
  final void Function(
    List<String> images,
    String title,
    String description,
    double? priceMax,
  )?
  onSubmitCreate;
  final void Function(
    YourRequestsBodyViewModel yourRequestsBodyViewModel,
    String title,
    String description,
    bool repaired,
    List<String> images,
    double? priceMax,
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
  late TextEditingController priceController;
  List<String> images = [];

  @override
  void initState() {
    print(widget.requestsBodyViewModel?.communityPrintRequest.toString());
    super.initState();
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
    priceController = TextEditingController(
      text: price != null ? price.toString() : "",
    );
    descriptionController = TextEditingController(text: description);
    titleController = TextEditingController(text: title);
  }

  @override
  Widget build(BuildContext context) {
    ChatBodyViewModel vm = ChatBodyViewModel(
      User("1", "mathilda", "Schulz", "hannover", "url", null, null),
      Chat("2", ChatStatus.done, "3", "4", null),
      Message("4", "Hey, ja das mache ich", DateTime.now(), "6", "2"),
      CommunityPrintRequest("3", 500, "7"),
      Item(
        "7",
        RepairStatus.broken,
        "Autoteil",
        "Beschreinung",
        "",
        "meineid",
        "3",
      ),
      Participant("ownParticipantId", ParticipantRole.helpProvider, "4", "2"),
      Participant("otherParticipantId", ParticipantRole.helpReceiver, "1", "2"),
    );
    List<ChatBodyViewModel> vms = [vm, vm];
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
                if (widget.requestsBodyViewModel != null)
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
                          "CAD verwalten",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          "letzte Änderung: ",
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        AppSecondaryButton(
                          child: Row(
                            children: [
                              Icon(Icons.arrow_circle_down),
                              SizedBox(width: 10),
                              Text("Herunterladen"),
                            ],
                          ),
                          onPressed: () {},
                        ),
                        AppSecondaryButton(
                          child: Row(
                            children: [
                              Icon(Icons.sync),
                              SizedBox(width: 10),
                              Text("Erneut Generieren"),
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                AppTextField(hint: "Titel", controller: titleController),
                AppTextField(
                  hint: "Beschreibung",
                  controller: descriptionController,
                ),
                Row(
                  spacing: 10.0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Switch(
                      value: hasRequest ,
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
                          AppTextField(
                            hint: "Preis max",
                            controller: priceController,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (hasRequest == true)
                  Column(
                    spacing: 10.0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Deine Chats zu dieser Anfrage: ",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),

                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder:
                            (context, index) =>
                                ChatEntry(chatBodyViewModel: vms[index]),
                        separatorBuilder:
                            (context, index) => SizedBox(height: 10),
                        itemCount: vms.length,
                      ),
                    ],
                  ),
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
                            hasRequest == true
                                ? double.parse(priceController.text)
                                : null,
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

                            hasRequest == true
                                ? double.parse(priceController.text)
                                : null,
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
