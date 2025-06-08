import 'package:json_annotation/json_annotation.dart';
import 'package:reconstructitapp/domain/entity_models/entity.dart';


part 'address.g.dart';

@JsonSerializable()
class Address extends Entity{
  final String streetAndHouseNumber;
  final String city;
  final String? zipCode;


  Address(super.id, this.streetAndHouseNumber, this.city, this.zipCode);

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);


  Map<String, dynamic> toJson() => _$AddressToJson(this);

}