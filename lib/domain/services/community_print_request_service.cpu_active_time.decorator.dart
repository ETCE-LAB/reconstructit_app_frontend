// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// MeasureCpuActiveTimeGenerator
// **************************************************************************

part of 'community_print_request_service.dart';

class CommunityPrintRequestServiceCpuActiveTimeDecorator
    extends CommunityPrintRequestService {
  final CommunityPrintRequestService _inner;
  CommunityPrintRequestServiceCpuActiveTimeDecorator(this._inner);
  @override
  Future<Result<List<CommunityPrintRequest>>>
  getAllCommunityPrintRequests() async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.getAllCommunityPrintRequests();
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for getAllCommunityPrintRequests: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<CommunityPrintRequest>> getCommunityPrintRequest(
    String id,
  ) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.getCommunityPrintRequest(id);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for getCommunityPrintRequest: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<CommunityPrintRequest>> createCommunityPrintRequest(
    CommunityPrintRequest request,
  ) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.createCommunityPrintRequest(request);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for createCommunityPrintRequest: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<void>> updateCommunityPrintRequest(
    CommunityPrintRequest request,
  ) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.updateCommunityPrintRequest(request);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for updateCommunityPrintRequest: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<void>> deleteCommunityPrintRequest(String id) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.deleteCommunityPrintRequest(id);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for deleteCommunityPrintRequest: ${end - start}ms");
    return result;
  }
}
