import '../../domain/entity_models/construction_file.dart';
import '../../domain/services/construction_file_service.dart';
import '../../utils/result.dart';
import '../sources/remote_datasource.dart';

class ConstructionFileRepository implements ConstructionFileService {
  final IRemoteDatasource remoteDatasource;
  ConstructionFileRepository(this.remoteDatasource);

  @override
  Future<Result<ConstructionFile>> getConstructionFile(String id) async {
    try {
      return Result.success(await remoteDatasource.getConstructionFile(id));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<ConstructionFile>> createConstructionFile(ConstructionFile file) async {
    try {
      return Result.success(await remoteDatasource.createConstructionFile(file));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<void>> updateConstructionFile(ConstructionFile file) async {
    try {
      await remoteDatasource.updateConstructionFile(file.id!, file);
      return Result.success(() {});
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }
}