import 'package:json_annotation/json_annotation.dart';
import 'package:reconstructitapp/domain/entity_models/entity.dart';
import 'package:reconstructitapp/domain/entity_models/enums/payment_status.dart';

part 'payment.g.dart';

@JsonSerializable()
class Payment extends Entity {
  final PaymentStatus paymentStatus;
  final String paymentMethodId;
  final String printContractId;

  Payment(
    super.id,
    this.paymentStatus,
    this.paymentMethodId,
    this.printContractId,
  );

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
