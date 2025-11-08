import 'dart:async';

import 'package:reconstructitapp/measuring/annotations.dart';

import '../../utils/result.dart';
import '../entity_models/address.dart';


@MeasureCpuActiveTime()
abstract class AddressService {
  Future<Result<Address>> getAddress(String id);

  Future<Result<Address>> getAddressByUserId(String userId);

  Future<Result<Address>> createAddress(Address address);

  Future<Result<void>> editAddress(Address address);

  Future<Result<void>> deleteAddress(String id);
}
