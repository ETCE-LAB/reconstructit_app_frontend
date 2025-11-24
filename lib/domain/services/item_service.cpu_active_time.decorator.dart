// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// MeasureCpuActiveTimeGenerator
// **************************************************************************

part of 'item_service.dart';

class ItemServiceCpuActiveTimeDecorator extends ItemService {
  final ItemService _inner;
  ItemServiceCpuActiveTimeDecorator(this._inner);
  @override
  Future<Result<Item>> getItem(String id) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.getItem(id);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for getItem: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<List<Item>>> getItemsForUserId(String userId) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.getItemsForUserId(userId);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for getItemsForUserId: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<Item>> createItem(Item item) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.createItem(item);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for createItem: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<void>> updateItem(Item item) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.updateItem(item);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for updateItem: ${end - start}ms");
    return result;
  }
}
