import 'package:json_annotation/json_annotation.dart';
import 'package:reconstructitapp/domain/entity_models/entity.dart';
import 'package:reconstructitapp/domain/entity_models/enums/print_contract_status.dart';
import 'package:reconstructitapp/domain/entity_models/enums/shipping_status.dart';
part 'print_contract.g.dart';

@JsonSerializable()
class PrintContract extends Entity {
  final PrintContractStatus contractStatus;
  final ShippingStatus shippingStatus;
  final String? paymentId;
  final String? revealedAddressId;
  final String communityPrintRequestId;

  PrintContract(
    super.id,
    this.contractStatus,
    this.shippingStatus,
    this.paymentId,
    this.revealedAddressId,
    this.communityPrintRequestId,
  );

  factory PrintContract.fromJson(Map<String, dynamic> json) =>
      _$PrintContractFromJson(json);

  Map<String, dynamic> toJson() => _$PrintContractToJson(this);
}
