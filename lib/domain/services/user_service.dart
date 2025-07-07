import 'dart:async';

import '../../utils/result.dart';
import '../entity_models/user.dart';

abstract class UserService {
  Future<Result<User?>> getCurrentUser();

  Future<Result<String>> getUserId();


  Future<Result<User>> getUser(String id);

  Future<Result<User>> createUser(
    String firstName,
    String lastName,
    String? profilePictureFileUrl, String region
  );

  Future<Result<void>> editUser(User user);
}
