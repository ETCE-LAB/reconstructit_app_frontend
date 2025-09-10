import 'dart:io';
import '../../utils/result.dart';

abstract class MediaService {
  Future<Result<String>> postImage(File image);


  Future<Result<String>> postModel(File model);
}
