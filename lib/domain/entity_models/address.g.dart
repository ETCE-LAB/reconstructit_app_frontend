// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
  json['id'] as String?,
  json['streetAndHouseNumber'] as String,
  json['city'] as String,
  json['zipCode'] as String,
  json['country'] as String,
  json['userId'] as String,
);

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
  'id': instance.id,
  'streetAndHouseNumber': instance.streetAndHouseNumber,
  'city': instance.city,
  'zipCode': instance.zipCode,
  'country': instance.country,
  'userId': instance.userId,
};
