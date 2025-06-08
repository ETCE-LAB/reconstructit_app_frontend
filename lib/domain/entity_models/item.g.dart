// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
  json['id'] as String?,
  $enumDecode(_$RepairStatusEnumMap, json['status']),
  json['title'] as String,
  json['description'] as String,
  json['constructionFileId'] as String?,
  json['userId'] as String,
  json['communityPrintRequestId'] as String?,
);

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
  'id': instance.id,
  'status': _$RepairStatusEnumMap[instance.status]!,
  'title': instance.title,
  'description': instance.description,
  'constructionFileId': instance.constructionFileId,
  'userId': instance.userId,
  'communityPrintRequestId': instance.communityPrintRequestId,
};

const _$RepairStatusEnumMap = {RepairStatus.broken: 0, RepairStatus.fixed: 1};
