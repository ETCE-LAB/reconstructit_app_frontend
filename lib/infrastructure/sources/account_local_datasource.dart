import 'dart:io';

import 'package:jwt_decode/jwt_decode.dart';
import 'package:oauth2/oauth2.dart';

import '../../../utils/clients/app_path_provider.dart';

abstract class IAccountLocalDatasource {
  Future<String> getUserAccountId();
}

class AccountLocalDatasource implements IAccountLocalDatasource {
  @override
  Future<String> getUserAccountId() async {
    // Read credentials file
    String credentialsPath = await AppPathProvider.getCredentialsPath();
    // //print(credentialsPath);
    final credentialsFile = File(credentialsPath);
    // Create credentials object
    var credentials = Credentials.fromJson(
      await credentialsFile.readAsString(),
    );
    // Parse access token
    Map<String, dynamic> decodedToken = Jwt.parseJwt(credentials.accessToken);
    //print(decodedToken);
    return decodedToken["sub"];
  }
}
