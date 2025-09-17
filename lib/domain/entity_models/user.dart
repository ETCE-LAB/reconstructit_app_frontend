import 'package:json_annotation/json_annotation.dart';
import 'package:reconstructitapp/domain/entity_models/entity.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Entity {
  final String firstName;
  final String lastName;
  final String region;
  final String? userProfilePictureUrl;

  final String? userAccountId;

  User(
    super.id,
    this.firstName,
    this.lastName,
    this.region,
    this.userProfilePictureUrl,
    this.userAccountId,
  );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
