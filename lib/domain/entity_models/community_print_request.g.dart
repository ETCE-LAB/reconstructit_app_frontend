// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_print_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityPrintRequest _$CommunityPrintRequestFromJson(
  Map<String, dynamic> json,
) => CommunityPrintRequest(
  json['id'] as String?,
  (json['priceMax'] as num?)?.toDouble(),
  json['itemId'] as String,
  $enumDecode(_$PrintMaterialEnumMap, json['printMaterial']),
);

Map<String, dynamic> _$CommunityPrintRequestToJson(
  CommunityPrintRequest instance,
) => <String, dynamic>{
  'id': instance.id,
  'priceMax': instance.priceMax,
  'itemId': instance.itemId,
  'printMaterial': _$PrintMaterialEnumMap[instance.printMaterial]!,
};

const _$PrintMaterialEnumMap = {PrintMaterial.pla: 0, PrintMaterial.cpe: 1};
