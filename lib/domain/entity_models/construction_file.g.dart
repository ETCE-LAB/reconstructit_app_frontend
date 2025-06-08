// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'construction_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConstructionFile _$ConstructionFileFromJson(Map<String, dynamic> json) =>
    ConstructionFile(
      json['id'] as String?,
      json['itemId'] as String,
      DateTime.parse(json['createdAt'] as String),
      json['fileUrl'] as String,
    );

Map<String, dynamic> _$ConstructionFileToJson(ConstructionFile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'fileUrl': instance.fileUrl,
      'itemId': instance.itemId,
    };
