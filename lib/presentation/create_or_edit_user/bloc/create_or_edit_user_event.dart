import 'package:reconstructitapp/domain/entity_models/address.dart';

import '../../../domain/entity_models/user.dart';

class CreateOrEditUserEvent {}

class CreateUser extends CreateOrEditUserEvent {
  final String? profilePicture;
  final String fistName;
  final String lastName;
  final String region;
  final String? streetHouseNumber;
  final String? zipCode;
  final String? city;

  CreateUser(
    this.profilePicture,
    this.fistName,
    this.lastName,
    this.region,
    this.streetHouseNumber,
    this.zipCode,
    this.city,
  );
}

class EditUser extends CreateOrEditUserEvent {
  final User oldUser;
  final Address? oldAddress;
  final String? profilePicture;
  final String firstName;
  final String lastName;
  final String region;
  final String? streetHouseNumber;
  final String? zipCode;
  final String? city;

  EditUser(
    this.oldUser,
    this.oldAddress,
    this.profilePicture,
    this.firstName,
    this.lastName,
    this.region,
    this.streetHouseNumber,
    this.zipCode,
    this.city,
  );
}
