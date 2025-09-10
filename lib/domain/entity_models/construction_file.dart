import 'package:json_annotation/json_annotation.dart';
import 'package:reconstructitapp/domain/entity_models/entity.dart';


part 'construction_file.g.dart';

@JsonSerializable()
class ConstructionFile extends Entity{
  final DateTime createdAt;
  final String fileUrl;
  final String itemId;


  ConstructionFile(super.id, this.itemId, this.createdAt, this.fileUrl);

  factory ConstructionFile.fromJson(Map<String, dynamic> json) =>
      _$ConstructionFileFromJson(json);


  Map<String, dynamic> toJson() => _$ConstructionFileToJson(this);

}