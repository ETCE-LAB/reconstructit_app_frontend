import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oauth2/oauth2.dart';
import 'package:path_provider/path_provider.dart';
import '../../presentation/authentication/authentication_screen.dart';
import '../app_settings.dart';

class AuthenticationInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    // Get access token from local credentials
    print(options.path);
    var accessToken = await _getAndRefreshAccessToken();

    log(accessToken.toString());

    // Start authentication process when access token is not available
    if (accessToken == null) {
      // Await authentication screen completion
      await Navigator.push(
        AppSettings.navigatorState.currentContext!,
        MaterialPageRoute(builder: (_) => const AuthenticationScreen()),
      );
      print("access token came bacj");

      // Retry loading the access token
      accessToken = await _getAndRefreshAccessToken();
    }

    // Attach access token to request header
    options.headers['Authorization'] = 'Bearer $accessToken';

    super.onRequest(options, handler);
  }

  static Future<String?> _getAndRefreshAccessToken() async {
    try {
      var docDir = await getApplicationDocumentsDirectory();
      final credentialsPath = '${docDir.path}/credentials.json';

      final credentialsFile = File(credentialsPath);
      // Deserialize local credentials
      var credentials = Credentials.fromJson(
        await credentialsFile.readAsString(),
      );
      if (credentials.isExpired) {
        // Refresh local credentials
        credentials = await credentials.refresh();

        // Update local credentials
        await File(credentialsPath).writeAsString(credentials.toJson());
      }

      return credentials.accessToken;
    } catch (e) {
      return null;
    }
  }
}
