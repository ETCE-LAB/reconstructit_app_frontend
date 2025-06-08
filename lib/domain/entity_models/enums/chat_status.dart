import 'package:json_annotation/json_annotation.dart';

enum ChatStatus {
  @JsonValue(0)
  pending,
  @JsonValue(1)
  agreed,
  @JsonValue(2)
  done,
  @JsonValue(3)
  cancelled,
}
