import 'dart:io';
import 'package:reconstructitapp/infrastructure/sources/remote_datasource.dart';
import '../../domain/services/media_service.dart';
import '../../utils/result.dart';

class MediaRepository extends MediaService {
  final IRemoteDatasource remoteDatasource;

  MediaRepository(this.remoteDatasource);
  @override
  Future<Result<String>> postImage(File image) async {
    try {
      var result = await remoteDatasource.postImage(image);
      return Result.success(result.fileUri);
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }
}
