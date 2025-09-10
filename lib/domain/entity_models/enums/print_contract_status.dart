import 'package:json_annotation/json_annotation.dart';

enum PrintContractStatus {
  @JsonValue(0)
  pending,
  @JsonValue(1)
  accepted,

  @JsonValue(2)
  printed,
  @JsonValue(3)
  done,
  @JsonValue(4)
  disputed,
  @JsonValue(5)
  cancelled,
}
