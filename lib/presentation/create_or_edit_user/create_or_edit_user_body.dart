import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reconstructitapp/components/AppButton.dart';
import 'package:reconstructitapp/components/AppSecondaryButton.dart';
import 'package:reconstructitapp/presentation/create_or_edit_user/bloc/create_or_edit_user_bloc.dart';
import 'package:reconstructitapp/presentation/create_or_edit_user/bloc/create_or_edit_user_state.dart';
import 'package:reconstructitapp/presentation/create_or_edit_user/local_components/change_profile_picture_bottom_sheet.dart';
import 'package:reconstructitapp/presentation/start/initial_start_screen.dart';
import 'package:reconstructitapp/utils/presenter.dart';

import '../../../domain/entity_models/address.dart';
import '../../../domain/entity_models/user.dart';
import '../../components/AppTextButton.dart';
import '../../components/AppTextField.dart';
import '../logout/logout_screen.dart';

class CreateOrEditUser extends StatefulWidget {
  final User? user;
  final Address? address;
  final void Function(
    String? profilePicture,
    String fistName,
    String lastName,
    String region,
    String? streetHouseNumber,
    String? zipCode,
    String? city,
    String? country,
  )?
  onCreate;
  final void Function(
    User oldUser,
    Address? oldAddress,
    String? profilePicture,
    String fistName,
    String lastName,
    String region,
    String? streetHouseNumber,
    String? zipCode,
    String? city,
    String? country,
  )?
  onEdit;
  final String buttonText;

  const CreateOrEditUser({
    super.key,
    this.user,
    this.address,

    required this.buttonText,
    this.onCreate,
    this.onEdit,
  });

  @override
  State<CreateOrEditUser> createState() => _CreateOrEditUserState();
}

class _CreateOrEditUserState extends State<CreateOrEditUser> {
  late String? firstName;
  late String? lastName;
  late String? region;
  late String? userProfilePictureUrl;

  late String? streetAndHouseNumber;
  late String? zipCode;
  late String? city;
  late String? country;

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController regionController;
  late TextEditingController streetAndHouseNumberController;
  late TextEditingController zipCodeController;
  late TextEditingController cityController;
  late TextEditingController countryController;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    firstName = widget.user?.firstName;
    lastName = widget.user?.lastName;
    region = widget.user?.region;
    userProfilePictureUrl = widget.user?.userProfilePictureUrl;
    streetAndHouseNumber = widget.address?.streetAndHouseNumber;
    zipCode = widget.address?.zipCode;
    city = widget.address?.city;
    country = widget.address?.country;
    firstNameController = TextEditingController(text: firstName);
    lastNameController = TextEditingController(text: lastName);
    regionController = TextEditingController(text: region);
    streetAndHouseNumberController = TextEditingController(
      text: streetAndHouseNumber,
    );
    zipCodeController = TextEditingController(text: zipCode);
    cityController = TextEditingController(text: city);

    countryController = TextEditingController(text: country);
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      userProfilePictureUrl = pickedFile?.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateOrEditUserBloc, CreateOrEditUserState>(
      listener: (context, state) {
        if (state is CreateOrEditUserLoading) {
          print("loding im listener");
        } else if (state is CreateOrEditUserSucceeded) {
          print(state.message);
          Presenter().presentSuccess(context, state.message);
        } else if (state is CreateOrEditUserFailed) {
          Presenter().presentFailure(context);
        }
      },
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  spacing: 10.0,
                  children: [
                    // profile picture
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.surfaceContainer,
                        ),

                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 40,
                            right: 40,
                            top: 40,
                            bottom: 10,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child:
                                      userProfilePictureUrl == null
                                          ? Image.asset(
                                            "assets/round_avatar_placeholder.jpg",
                                          )
                                          : userProfilePictureUrl!.startsWith(
                                            "http",
                                          )
                                          ? Image.network(
                                            userProfilePictureUrl!,
                                            fit: BoxFit.cover,
                                          )
                                          : Image.file(
                                            File(userProfilePictureUrl!),
                                            fit: BoxFit.cover,
                                          ),
                                ),
                              ),

                              Text(
                                "${firstName ?? ""} ${lastName ?? ""}",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Text(
                                region ?? "",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: AppTextButton(
                        onPressed:
                            userProfilePictureUrl != null
                                ? () {
                                  showModalBottomSheet(
                                    showDragHandle: true,
                                    context: context,
                                    isScrollControlled: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(40),
                                      ),
                                    ),
                                    builder:
                                        (_) => ChangeProfilePictureBottomSheet(
                                          onDelete: () {
                                            setState(() {
                                              userProfilePictureUrl = null;
                                            });
                                          },
                                          onPickImage: _pickImage,
                                        ),
                                  );
                                }
                                : _pickImage,
                        child: Text(
                          userProfilePictureUrl != null
                              ? "Profilbild ändern"
                              : "Profilbild aus Galerie wählen",
                        ),
                      ),
                    ),
                    // text fields
                    AppTextField(
                      hint: "Vorname",
                      controller: firstNameController,
                    ),
                    AppTextField(
                      hint: "Nachname",
                      controller: lastNameController,
                    ),
                    AppTextField(
                      hint: "Region (z.B. Braunschweig oder Harz)",
                      controller: regionController,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Deine Adresse"),
                    ),
                    AppTextField(
                      hint: "Straße und Hausnummer",
                      controller: streetAndHouseNumberController,
                    ),
                    AppTextField(
                      hint: "Postleitzahl",
                      controller: zipCodeController,
                    ),
                    AppTextField(hint: "Stadt", controller: cityController),
                    AppTextField(hint: "Land", controller: countryController),
                  ],
                ),
                AppSecondaryButton(
                  child: Text("Abmelden"),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => LogoutScreen(
                              onLoggedOut: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InitialStartScreen(),
                                  ),
                                );
                              },
                            ),
                      ),
                    );
                  },
                ),
                AppButton(
                  onPressed:
                      widget.onEdit == null
                          ? () {
                            widget.onCreate!(
                              userProfilePictureUrl,
                              firstNameController.text,
                              lastNameController.text,
                              regionController.text,
                              streetAndHouseNumberController.text,
                              zipCodeController.text,
                              cityController.text,
                              countryController.text,
                            );
                          }
                          : () {
                            widget.onEdit!(
                              widget.user!,
                              widget.address,
                              userProfilePictureUrl,
                              firstNameController.text,
                              lastNameController.text,
                              regionController.text,
                              streetAndHouseNumberController.text,
                              zipCodeController.text,
                              cityController.text,
                              countryController.text,
                            );
                          },
                  // onPressed: widget.onSubmit,
                  child: Text(widget.buttonText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
