// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// MeasureCpuActiveTimeGenerator
// **************************************************************************

part of 'address_service.dart';

class AddressServiceCpuActiveTimeDecorator extends AddressService {
  final AddressService _inner;
  AddressServiceCpuActiveTimeDecorator(this._inner);
  @override
  Future<Result<Address>> getAddress(String id) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.getAddress(id);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for getAddress: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<Address>> getAddressByUserId(String userId) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.getAddressByUserId(userId);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for getAddressByUserId: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<Address>> createAddress(Address address) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.createAddress(address);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for createAddress: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<void>> editAddress(Address address) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.editAddress(address);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for editAddress: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<void>> deleteAddress(String id) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.deleteAddress(id);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for deleteAddress: ${end - start}ms");
    return result;
  }
}
