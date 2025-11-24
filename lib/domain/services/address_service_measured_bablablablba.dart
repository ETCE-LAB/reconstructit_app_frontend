import 'dart:async';
import 'dart:developer';

import 'package:reconstructitapp/domain/services/address_service.dart';

import '../../measuring/platform_channel/cpu_active_time_platform_channel.dart';
import '../../utils/result.dart';
import '../entity_models/address.dart';

class AddressServiceMeasured extends AddressService {
  final AddressService _inner;

  AddressServiceMeasured(this._inner);

  @override
  Future<Result<Address>> createAddress(Address address) async {
    final start = await CPUActiveTimePlatformChannel.getCPUTime();
    var result = await _inner.createAddress(address);
    final end = await CPUActiveTimePlatformChannel.getCPUTime();
    if (end != -1 && start != -1) {
      log("CPU ACTIVE TIME (createAddress): ${end - start} ms");
    }
    return result;
  }

  @override
  Future<Result<void>> deleteAddress(String id) async {
    final start = await CPUActiveTimePlatformChannel.getCPUTime();
    var result = await _inner.deleteAddress(id);
    final end = await CPUActiveTimePlatformChannel.getCPUTime();
    if (end != -1 && start != -1) {
      log("CPU ACTIVE TIME (deleteAddress): ${end - start} ms");
    }
    return result;
  }

  @override
  Future<Result<void>> editAddress(Address address) async {
    final start = await CPUActiveTimePlatformChannel.getCPUTime();
    var result = await _inner.editAddress(address);
    final end = await CPUActiveTimePlatformChannel.getCPUTime();
    if (end != -1 && start != -1) {
      log("CPU ACTIVE TIME (editAddress): ${end - start} ms");
    }
    return result;
  }

  @override
  Future<Result<Address>> getAddress(String id) async {
    final start = await CPUActiveTimePlatformChannel.getCPUTime();
    var result = await _inner.getAddress(id);
    final end = await CPUActiveTimePlatformChannel.getCPUTime();
    if (end != -1 && start != -1) {
      log("CPU ACTIVE TIME (getAddress): ${end - start} ms");
    }
    return result;
  }

  @override
  Future<Result<Address>> getAddressByUserId(String userId) async {
    final start = await CPUActiveTimePlatformChannel.getCPUTime();
    var result = await _inner.getAddressByUserId(userId);
    final end = await CPUActiveTimePlatformChannel.getCPUTime();
    if (end != -1 && start != -1) {
      log("CPU ACTIVE TIME (getAddressByUserId): ${end - start} ms");
    }
    return result;
  }
}
