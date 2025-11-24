import 'dart:async';

import 'package:clean_ressource_tracker/clean_ressource_tracker.dart';

import '../../utils/result.dart';
import '../entity_models/user.dart';

part 'user_service.cpu_active_time.decorator.dart';
part 'user_service.builder.dart';

@WithBuilder()
@MeasureCpuActiveTime()
abstract class UserService {
  Future<Result<User?>> getCurrentUser();

  Future<Result<String>> getUserAccountId();

  Future<Result<User>> getUser(String id);

  Future<Result<User>> createUser(
    String firstName,
    String lastName,
    String? profilePictureFileUrl,
    String region,
  );

  Future<Result<void>> editUser(User user);
}
