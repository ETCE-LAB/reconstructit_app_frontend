import 'package:reconstructitapp/domain/entity_models/address.dart';
import 'package:reconstructitapp/domain/entity_models/construction_file.dart';
import 'package:reconstructitapp/domain/entity_models/enums/participant_role.dart';
import 'package:reconstructitapp/domain/entity_models/enums/payment_status.dart';
import 'package:reconstructitapp/domain/entity_models/enums/print_contract_status.dart';
import 'package:reconstructitapp/domain/entity_models/enums/shipping_status.dart';
import 'package:reconstructitapp/domain/entity_models/item_image.dart';
import 'package:reconstructitapp/domain/entity_models/payment.dart';
import 'package:reconstructitapp/domain/entity_models/payment_attribute.dart';
import 'package:reconstructitapp/domain/entity_models/payment_method.dart';
import 'package:reconstructitapp/domain/entity_models/payment_value.dart';
import 'package:reconstructitapp/domain/entity_models/print_contract.dart';

import '../../domain/entity_models/community_print_request.dart';
import '../../domain/entity_models/item.dart';
import '../../domain/entity_models/user.dart';

class PrintContractViewModel {
  // used to coordinate the names/pronouns
  final ParticipantRole? ownRole;
  final User? ownUser;

  final ConstructionFile? constructionFile;

  // used only for the name
  final User? otherUser;

  // used for the ShippingStatus and PrintContractStatus
  final PrintContract? printContract;

  // used for the price and the material
  final CommunityPrintRequest? communityPrintRequest;

  // used for the payment method name
  final PaymentMethod? paymentMethod;
  final List<PaymentAttribute>? paymentAttributes;
  final List<PaymentValue>? paymentValues;
  final Item? item;

  // used for the address, step 3
  final Address? address;

  // used for the payment Status, step 4 and 5
  final Payment? payment;
  final List<ItemImage>? itemImages;

  final bool isLoading;

  PrintContractViewModel(  {this.ownUser,this.constructionFile,
    this.ownRole,
    this.otherUser,
    this.printContract,
    this.communityPrintRequest,
    this.paymentMethod,
    this.paymentAttributes,
    this.paymentValues,
    this.itemImages,
    this.address,
    this.payment,
    this.item,
    required this.isLoading,
  });

  // for the overview
  String? getLatestStatus() {
    // status is done
    if (printContract != null &&
        printContract!.contractStatus == PrintContractStatus.done) {
      return "Abgeschlossen";
    }
    // shipping
    if (printContract != null) {
      if (printContract!.shippingStatus == ShippingStatus.received) {
        return "Sendung erhalten";
      } else if (printContract!.shippingStatus == ShippingStatus.sent) {
        return "Sendung versendet";
      }
    }
    // status is printed
    if (printContract != null &&
        printContract!.contractStatus == PrintContractStatus.printed) {
      return "Druck abgeschlossen";
    }
    // payment
    if (payment != null) {
      if (payment!.paymentStatus == PaymentStatus.paymentDone) {
        return "Zahlungsausgang bestätigt";
      } else if (payment!.paymentStatus == PaymentStatus.paymentConfirmed) {
        return "Zahlungseingang bestätigt";
      }
    }
    // status
    if (printContract != null) {
      if (printContract!.contractStatus == PrintContractStatus.accepted) {
        return "Angebot angenommen";
      } else if (printContract!.contractStatus == PrintContractStatus.pending) {
        return "Angebot ausstehend";
      } else if (printContract!.contractStatus ==
          PrintContractStatus.cancelled) {
        return "Abgebrochen";
      }
    }
    return null;
  }
}
