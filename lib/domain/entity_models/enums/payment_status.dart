import 'package:json_annotation/json_annotation.dart';

enum PaymentStatus {
  @JsonValue(0)
  pending,
  @JsonValue(1)
  paymentDone,
  @JsonValue(2)
  paymentConfirmed,
}
