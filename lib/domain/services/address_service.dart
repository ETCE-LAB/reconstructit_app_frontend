import 'dart:async';

import '../../utils/result.dart';
import '../entity_models/address.dart';

abstract class AddressService {
  /// Get an address by id - used to get a foreign users address
  Future<Result<Address>> getAddress(String id);

  /// Get an address by the user id - used to get the own address
  Future<Result<Address>> getAddressByUserId(String userId);

  /// Create an address - used to create your own address
  Future<Result<Address>> createAddress(Address address);

  /// Edit an address - used to edit your own address
  Future<Result<void>> editAddress(Address address);

  /// Delete an address - used to delete your own address
  Future<Result<void>> deleteAddress(String id);
}
