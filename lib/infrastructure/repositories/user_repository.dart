import 'package:dio/dio.dart';
import 'package:reconstructitapp/domain/entity_models/user.dart';
import 'package:reconstructitapp/infrastructure/sources/remote_datasource.dart';
import 'package:reconstructitapp/utils/result.dart';

import '../../domain/services/user_service.dart';
import '../sources/account_local_datasource.dart';


class UserRepository implements UserService {
  final IRemoteDatasource remoteDatasource;
  final IAccountLocalDatasource accountLocalDatasource;

  UserRepository(this.remoteDatasource,
      this.accountLocalDatasource,);

  @override
  Future<Result<User?>> getCurrentUser() async {
    try {
      // Get User id from local credentials

      String userAccountId = await accountLocalDatasource.getUserAccountId();
     // String userAccountId = "f075ac97-1234-43c0-8938-1d5334c5eb01";
      // Get  from API
      User user = await remoteDatasource
          .getUserWithUserAccountId(userAccountId);
      return Result.success(user);
    } catch (e) {
      if(e is DioException){
        if(e.response?.statusCode ==404){
          return Result.success(null);
        }
      }

      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<String>> getUserId() async {
    try {
      // Get User id from local credentials
      String platformUserId = await accountLocalDatasource.getUserAccountId();
      return Result.success(platformUserId);
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<User>> createUser(String firstName,
      String lastName,
      String? profilePictureFileUrl,String region) async {
    try {
      // get user account id
      String userAccountId = await accountLocalDatasource.getUserAccountId();
      User newUser = User(
        null,
        firstName,
        lastName,
        region,
        profilePictureFileUrl,
        null,
        userAccountId
      );
      print(newUser.toJson());
      return Result.success(
        await remoteDatasource.createUserProfile(newUser),
      );
    } catch (e) {
      print(e);
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<void>> editUser(User user) async {
    try {

      await remoteDatasource.editUserProfile(
        user.id!,
        user,
      );
      return Result.success(() {});
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<User>> getUser(String id) async {
    try {
      // Get User id from local credentials
      User user = await remoteDatasource.getUser(id);
      return Result.success(user);
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }


}
