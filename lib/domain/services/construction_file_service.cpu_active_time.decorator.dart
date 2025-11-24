// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// MeasureCpuActiveTimeGenerator
// **************************************************************************

part of 'construction_file_service.dart';

class ConstructionFileServiceCpuActiveTimeDecorator
    extends ConstructionFileService {
  final ConstructionFileService _inner;
  ConstructionFileServiceCpuActiveTimeDecorator(this._inner);
  @override
  Future<Result<ConstructionFile>> getConstructionFile(String id) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.getConstructionFile(id);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for getConstructionFile: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<ConstructionFile>> createConstructionFile(
    ConstructionFile file,
  ) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.createConstructionFile(file);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for createConstructionFile: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<void>> updateConstructionFile(ConstructionFile file) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.updateConstructionFile(file);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for updateConstructionFile: ${end - start}ms");
    return result;
  }
}
