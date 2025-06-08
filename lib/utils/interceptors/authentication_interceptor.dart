import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oauth2/oauth2.dart';
import 'package:reconstructitapp/presentation/bloc/authentication_bloc.dart';

import '../../presentation/bloc/authentication_screen.dart';
import '../app_settings.dart';
import '../clients/app_path_provider.dart';

class AuthenticationInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    print(options.path);
    // Get credentials file
    String credentialsPath = await AppPathProvider.getCredentialsPath();
    final credentialsFile = File(credentialsPath);
    var exists = await credentialsFile.exists();
    if (exists) {
      // Deserialize local credentials
      var credentials = Credentials.fromJson(
        await credentialsFile.readAsString(),
      );
      if (credentials.isExpired) {
        // Refresh local credentials
        try {
          credentials = await credentials.refresh(identifier: appIdentifier);
        } catch (e) {
          // When refresh token is expired, redirect to authentication
          Navigator.push(
            AppSettings.navigatorState.currentContext!,
            MaterialPageRoute(builder: (_) => const AuthenticationScreen()),
          );
        }

        // Update local credentials
        await File(credentialsPath).writeAsString(credentials.toJson());
      }
      // Attach token to request header
      options.headers['Authorization'] = 'Bearer ${credentials.accessToken}';
      // options.headers['Authorization'] ='Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjY1ODUxN0ZFQURFRTQxMTk2M0RBNUYyNjBCMDc0QTlBIiwidHlwIjoiYXQrand0In0.eyJpc3MiOiJodHRwczovL2RldmVsb3BtZW50LWlzc2UtaWRlbnRpdHktYmFja2VuZC5henVyZXdlYnNpdGVzLm5ldCIsIm5iZiI6MTc0OTMwOTAzNCwiaWF0IjoxNzQ5MzA5MDM0LCJleHAiOjE3NDkzMTI2MzQsImF1ZCI6Imh0dHBzOi8vZGV2ZWxvcG1lbnQtaXNzZS1pZGVudGl0eS1iYWNrZW5kLmF6dXJld2Vic2l0ZXMubmV0L3Jlc291cmNlcyIsInNjb3BlIjpbIm9wZW5pZCIsImVtYWlsIiwib2ZmbGluZV9hY2Nlc3MiXSwiYW1yIjpbInB3ZCJdLCJjbGllbnRfaWQiOiJpbnRlcmFjdGl2ZSIsInN1YiI6ImYwNzVhYzk3LTEyMzQtNDNjMC04OTM4LTFkNTMzNGM1ZWIwMSIsImF1dGhfdGltZSI6MTc0NzY0MTMxNywiaWRwIjoibG9jYWwiLCJpZCI6ImYwNzVhYzk3LTEyMzQtNDNjMC04OTM4LTFkNTMzNGM1ZWIwMSIsInNpZCI6IkFGOUMxMEYxMDM5RkQyQUQyMkJFQkZBQTcwMTE1M0E3IiwianRpIjoiRTE4NzE0RTU1OURERDZGMEM2MkVBMTQwRjhGRDg3QkQifQ.IaAGIU_287vdi9vANXXQ-kSj_l6wmaJllxAB9tQW-NmxLm8FhIEPsAXDJSC5q-ZYYSw49A5f--vlfqaAuuSbnYFZQKyrq0Pi5FwlkPjvHZAqG4eo2idhQfFwHIMCmde4Q7AeeILSzLN8ZzYRyI6Xlym2ibDf2ieJ5UZ5SHcAUeazNamxVgZp_l35arIgi3P9JmpfDFMd2-cmsn80X_w3mlFMhdHhA0a_VPfmLA2EEN_KplrwQAD0xi47n1FUJ9LO4TkD-5qABWqsQel7Rgz4Jr-9uy4aOjRV_tPX_RyUZt2CPOEZi6WSZxQNeeFK_O9zj-pxjuLwrqAsDrxVaw4o0Q';
    } else {
      // Open auth screen when credentials are not found
      Navigator.push(
        AppSettings.navigatorState.currentContext!,
        MaterialPageRoute(builder: (_) => const AuthenticationScreen()),
      );
    }

    super.onRequest(options, handler);
  }
}
