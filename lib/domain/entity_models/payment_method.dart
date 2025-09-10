import 'package:json_annotation/json_annotation.dart';
import 'package:reconstructitapp/domain/entity_models/entity.dart';
import 'package:reconstructitapp/domain/entity_models/enums/payment_status.dart';

import 'enums/participant_role.dart';

part 'payment_method.g.dart';

@JsonSerializable()
class PaymentMethod extends Entity {

  final String name;

  PaymentMethod(super.id, this.name);


  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);


  Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);
}