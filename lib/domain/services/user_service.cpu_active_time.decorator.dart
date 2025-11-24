// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// MeasureCpuActiveTimeGenerator
// **************************************************************************

part of 'user_service.dart';

class UserServiceCpuActiveTimeDecorator extends UserService {
  final UserService _inner;
  UserServiceCpuActiveTimeDecorator(this._inner);
  @override
  Future<Result<User?>> getCurrentUser() async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.getCurrentUser();
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for getCurrentUser: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<String>> getUserAccountId() async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.getUserAccountId();
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for getUserAccountId: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<User>> getUser(String id) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.getUser(id);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for getUser: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<User>> createUser(
    String firstName,
    String lastName,
    String? profilePictureFileUrl,
    String region,
  ) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.createUser(
      firstName,
      lastName,
      profilePictureFileUrl,
      region,
    );
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for createUser: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<void>> editUser(User user) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.editUser(user);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for editUser: ${end - start}ms");
    return result;
  }
}
