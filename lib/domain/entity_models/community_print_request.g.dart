// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_print_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityPrintRequest _$CommunityPrintRequestFromJson(
  Map<String, dynamic> json,
) => CommunityPrintRequest(
  json['id'] as String?,
  (json['priceMax'] as num).toDouble(),
  json['itemId'] as String,
);

Map<String, dynamic> _$CommunityPrintRequestToJson(
  CommunityPrintRequest instance,
) => <String, dynamic>{
  'id': instance.id,
  'priceMax': instance.priceMax,
  'itemId': instance.itemId,
};
