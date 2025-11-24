// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// MeasureCpuActiveTimeGenerator
// **************************************************************************

part of 'item_image_service.dart';

class ItemImageServiceCpuActiveTimeDecorator extends ItemImageService {
  final ItemImageService _inner;
  ItemImageServiceCpuActiveTimeDecorator(this._inner);
  @override
  Future<Result<List<ItemImage>>> getItemImagesForItem(String itemId) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.getItemImagesForItem(itemId);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for getItemImagesForItem: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<ItemImage>> createItemImage(ItemImage image) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.createItemImage(image);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for createItemImage: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<void>> deleteItemImage(String id) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.deleteItemImage(id);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for deleteItemImage: ${end - start}ms");
    return result;
  }
}
