import 'dart:async';

import '../../utils/result.dart';
import '../entity_models/construction_file.dart';

abstract class ConstructionFileService {
  Future<Result<ConstructionFile>> getConstructionFile(String id);

  Future<Result<ConstructionFile>> createConstructionFile(ConstructionFile file);

  Future<Result<void>> updateConstructionFile(ConstructionFile file);
}
