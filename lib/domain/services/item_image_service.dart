import 'dart:async';

import '../../utils/result.dart';
import '../entity_models/item_image.dart';
import 'package:clean_ressource_tracker/clean_ressource_tracker.dart';

part 'item_image_service.cpu_active_time.decorator.dart';

part 'item_image_service.builder.dart';

@MeasureCpuActiveTime()
@WithBuilder()
abstract class ItemImageService {
  Future<Result<List<ItemImage>>> getItemImagesForItem(String itemId);

  Future<Result<ItemImage>> createItemImage(ItemImage image);

  Future<Result<void>> deleteItemImage(String id);
}
