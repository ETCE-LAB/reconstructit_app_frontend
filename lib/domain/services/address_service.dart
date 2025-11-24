import 'dart:async';
import 'package:clean_ressource_tracker/clean_ressource_tracker.dart';

import '../../utils/result.dart';
import '../entity_models/address.dart';

part 'address_service.cpu_active_time.decorator.dart';
part 'address_service.builder.dart';

@WithBuilder()
@MeasureCpuActiveTime()
abstract class AddressService {
  Future<Result<Address>> getAddress(String id);

  Future<Result<Address>> getAddressByUserId(String userId);

  Future<Result<Address>> createAddress(Address address);

  Future<Result<void>> editAddress(Address address);

  Future<Result<void>> deleteAddress(String id);
}
