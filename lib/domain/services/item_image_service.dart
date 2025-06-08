import 'dart:async';

import '../../utils/result.dart';
import '../entity_models/item_image.dart';

abstract class ItemImageService {
  Future<Result<List<ItemImage>>> getItemImagesForItem(String itemId);

  Future<Result<ItemImage>> createItemImage(ItemImage image);

  Future<Result<void>> deleteItemImage(String id);
}
