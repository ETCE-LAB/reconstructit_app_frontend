import 'package:json_annotation/json_annotation.dart';
import 'package:reconstructitapp/domain/entity_models/entity.dart';
import 'package:reconstructitapp/domain/entity_models/enums/repair_status.dart';
part 'item.g.dart';

@JsonSerializable()
class Item extends Entity {
  final RepairStatus status;

  final String title;
  final String description;
  final String? constructionFileId;
  final String userId;
  final String? communityPrintRequestId;

  Item(
    super.id,
    this.status,
    this.title,
    this.description,
    this.constructionFileId,
    this.userId,
    this.communityPrintRequestId,
  );

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
