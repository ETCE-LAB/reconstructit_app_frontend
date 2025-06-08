import 'package:flutter/material.dart';
import 'package:reconstructitapp/components/AppButton.dart';

import '../../../domain/entity_models/address.dart';
import '../../../domain/entity_models/user.dart';
import '../../components/AppTextButton.dart';
import '../../components/AppTextField.dart';

class CreateOrEditUser extends StatefulWidget {
  final User user;
  final Address? address;
  final void Function() onSubmit;
  final String buttonText;

  const CreateOrEditUser({
    super.key,
    required this.user,
    this.address,
    required this.onSubmit,
    required this.buttonText,
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

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController regionController;
  late TextEditingController streetAndHouseNumberController;
  late TextEditingController zipCodeController;
  late TextEditingController cityController;

  @override
  void initState() {
    super.initState();
    firstName = widget.user.firstName;
    lastName = widget.user.lastName;
    region = widget.user.region;
    userProfilePictureUrl = widget.user.userProfilePictureUrl;
    streetAndHouseNumber = widget.address?.streetAndHouseNumber;
    zipCode = widget.address?.zipCode;
    city = widget.address?.city;
    firstNameController = TextEditingController(text: firstName);
    lastNameController = TextEditingController(text: lastName);
    regionController = TextEditingController(text: region);
    streetAndHouseNumberController = TextEditingController(
      text: streetAndHouseNumber,
    );
    zipCodeController = TextEditingController(text: zipCode);
    cityController = TextEditingController(text: city);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(children: [Column(
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
                    padding: EdgeInsets.all(19),
                    child: Column(
                      children: [
                        Container(width: 100, height: 100, color: Colors.red),
                        Text(
                          "Alina Simon",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          "Cremlingen",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(child: AppTextButton(child: Text("Profilbild ändern"))),
              // text fields
              AppTextField(hint: "Vorname", controller: firstNameController),
              AppTextField(hint: "Nachname", controller: lastNameController),
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
              AppTextField(hint: "Postleitzahl", controller: zipCodeController),
              AppTextField(hint: "Stadt", controller: cityController),
            ],
          ),
          AppButton(onPressed: widget.onSubmit, child: Text(widget.buttonText))
          ])
        ),
      ),
    );
  }
}
