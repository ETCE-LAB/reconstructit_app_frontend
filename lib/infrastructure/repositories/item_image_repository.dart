import '../../domain/entity_models/item_image.dart';
import '../../domain/services/item_image_service.dart';
import '../../utils/result.dart';
import '../sources/remote_datasource.dart';

class ItemImageRepository implements ItemImageService {
  final IRemoteDatasource remoteDatasource;

  ItemImageRepository(this.remoteDatasource);

  @override
  Future<Result<List<ItemImage>>> getItemImagesForItem(String id) async {
    try {
      return Result.success(await remoteDatasource.getItemImagesForItem(id));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<ItemImage>> createItemImage(ItemImage image) async {
    try {
      return Result.success(await remoteDatasource.createItemImage(image));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<void>> deleteItemImage(String id) async {
    try {
      await remoteDatasource.deleteItemImage(id);
      return Result.success(() {});
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }
}
