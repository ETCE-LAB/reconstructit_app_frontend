import 'package:json_annotation/json_annotation.dart';

enum ShippingStatus {
  @JsonValue(0)
  pending,
  @JsonValue(1)
  sent,
  @JsonValue(2)
  received,
}
