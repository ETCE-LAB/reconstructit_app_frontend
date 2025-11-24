import 'dart:io';
import 'package:clean_ressource_tracker/clean_ressource_tracker.dart';

import '../../utils/result.dart';

part 'media_service.cpu_active_time.decorator.dart';
part 'media_service.builder.dart';

@WithBuilder()
@MeasureCpuActiveTime()
abstract class MediaService {
  Future<Result<String>> postImage(File image);


  Future<Result<String>> postModel(File model);
}
