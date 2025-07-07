import 'dart:async';

import '../../utils/result.dart';
import '../entity_models/address.dart';

abstract class AddressService {
  Future<Result<Address>> getAddress(String id);

  Future<Result<Address>> createAddress(Address address);

  Future<Result<void>> editAddress(Address address);

  Future<Result<void>> deleteAddress(String id);
}
