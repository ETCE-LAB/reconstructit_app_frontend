import 'package:json_annotation/json_annotation.dart';
import 'package:reconstructitapp/domain/entity_models/entity.dart';

part 'item_image.g.dart';

@JsonSerializable()
class ItemImage extends Entity {
  final String imageUrl;
  final String itemId;

  ItemImage(super.id, this.imageUrl, this.itemId);

  factory ItemImage.fromJson(Map<String, dynamic> json) =>
      _$ItemImageFromJson(json);

  Map<String, dynamic> toJson() => _$ItemImageToJson(this);
}
