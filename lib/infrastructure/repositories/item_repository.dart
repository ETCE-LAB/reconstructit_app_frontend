import '../../domain/entity_models/item.dart';
import '../../domain/services/item_service.dart';
import '../../utils/result.dart';
import '../sources/remote_datasource.dart';

class ItemRepository implements ItemService {
  final IRemoteDatasource remoteDatasource;
  ItemRepository(this.remoteDatasource);

  @override
  Future<Result<Item>> getItem(String id) async {
    try {
      return Result.success(await remoteDatasource.getItem(id));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<List<Item>>> getItemsForUserId(String userId) async {
    try {
      return Result.success(await remoteDatasource.getItemsByUser(userId));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<Item>> createItem(Item item) async {
    try {
      return Result.success(await remoteDatasource.createItem(item));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<void>> updateItem(Item item) async {
    try {
      await remoteDatasource.updateItem(item.id!, item);
      return Result.success(() {});
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }
}
