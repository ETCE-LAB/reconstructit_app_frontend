import 'dart:async';

import '../../utils/result.dart';
import '../entity_models/item.dart';

abstract class ItemService {
  Future<Result<Item>> getItem(String id);

  Future<Result<List<Item>>> getItemsForUserId(String userId);

  Future<Result<Item>> createItem(Item item);

  Future<Result<void>> updateItem(Item item);
}
