import 'dart:io';

import 'package:jwt_decode/jwt_decode.dart';
import 'package:oauth2/oauth2.dart';

import '../../../utils/clients/app_path_provider.dart';

abstract class IAccountLocalDatasource {
  Future<String> getUserAccountId();
  Future<String> getUserEmail();
  Future<String> getUserUserName();
}

class AccountLocalDatasource implements IAccountLocalDatasource {
  @override
  Future<String> getUserAccountId() async {
    // Read credentials file
    String credentialsPath = await AppPathProvider.getCredentialsPath();
    // //print(credentialsPath);
    final credentialsFile = File(credentialsPath);
    // Create credentials object
    var credentials =
        Credentials.fromJson(await credentialsFile.readAsString());
    // Parse access token
    Map<String, dynamic> decodedToken = Jwt.parseJwt(credentials.accessToken);
    //print(decodedToken);
    return decodedToken["sub"];
  }

  @override
  Future<String> getUserEmail() async {
    // Read credentials file
    String credentialsPath = await AppPathProvider.getCredentialsPath();
    // //print(credentialsPath);
    final credentialsFile = File(credentialsPath);
    // Create credentials object
    var credentials =
    Credentials.fromJson(await credentialsFile.readAsString());
    // Parse access token
    Map<String, dynamic> decodedToken = Jwt.parseJwt(credentials.accessToken);
    //print(decodedToken);
    return decodedToken["http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"];
  }

  @override
  Future<String> getUserUserName() async {
    // Read credentials file
    String credentialsPath = await AppPathProvider.getCredentialsPath();
    // //print(credentialsPath);
    final credentialsFile = File(credentialsPath);
    // Create credentials object
    var credentials =
    Credentials.fromJson(await credentialsFile.readAsString());
    // Parse access token
    Map<String, dynamic> decodedToken = Jwt.parseJwt(credentials.accessToken);
    //print(decodedToken);
    return decodedToken["http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"];
  }
}
