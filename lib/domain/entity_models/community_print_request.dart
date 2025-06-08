import 'package:json_annotation/json_annotation.dart';
import 'package:reconstructitapp/domain/entity_models/entity.dart';


part 'community_print_request.g.dart';

@JsonSerializable()
class CommunityPrintRequest extends Entity{
  final double priceMax;
  final String itemId;


  CommunityPrintRequest(super.id, this.priceMax, this.itemId);

  factory CommunityPrintRequest.fromJson(Map<String, dynamic> json) =>
      _$CommunityPrintRequestFromJson(json);


  Map<String, dynamic> toJson() => _$CommunityPrintRequestToJson(this);

}