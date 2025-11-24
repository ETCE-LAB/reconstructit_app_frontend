// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// MeasureCpuActiveTimeGenerator
// **************************************************************************

part of 'media_service.dart';

class MediaServiceCpuActiveTimeDecorator extends MediaService {
  final MediaService _inner;
  MediaServiceCpuActiveTimeDecorator(this._inner);
  @override
  Future<Result<String>> postImage(File image) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.postImage(image);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for postImage: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<String>> postModel(File model) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.postModel(model);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for postModel: ${end - start}ms");
    return result;
  }
}
