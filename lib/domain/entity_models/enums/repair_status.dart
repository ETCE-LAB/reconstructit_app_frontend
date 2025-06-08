import 'package:json_annotation/json_annotation.dart';

enum RepairStatus {
  @JsonValue(0)
  broken,
  @JsonValue(1)
  fixed;
}