import 'dart:async';

import '../../utils/result.dart';
import '../entity_models/construction_file.dart';
import 'package:clean_ressource_tracker/clean_ressource_tracker.dart';

part 'construction_file_service.cpu_active_time.decorator.dart';

part 'construction_file_service.builder.dart';

@MeasureCpuActiveTime()
@WithBuilder()
abstract class ConstructionFileService {
  Future<Result<ConstructionFile>> getConstructionFile(String id);

  Future<Result<ConstructionFile>> createConstructionFile(
      ConstructionFile file);

  Future<Result<void>> updateConstructionFile(ConstructionFile file);
}
