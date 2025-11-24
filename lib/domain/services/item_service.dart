import 'dart:async';

import 'package:clean_ressource_tracker/clean_ressource_tracker.dart';

import '../../utils/result.dart';
import '../entity_models/item.dart';

part 'item_service.cpu_active_time.decorator.dart';
part 'item_service.builder.dart';

@WithBuilder()
@MeasureCpuActiveTime()
abstract class ItemService {
  Future<Result<Item>> getItem(String id);

  Future<Result<List<Item>>> getItemsForUserId(String userId);

  Future<Result<Item>> createItem(Item item);

  Future<Result<void>> updateItem(Item item);
}
