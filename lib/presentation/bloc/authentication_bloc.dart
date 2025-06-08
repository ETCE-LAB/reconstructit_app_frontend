import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oauth2/oauth2.dart';

import '../../../../../utils/clients/app_path_provider.dart';
import '../../utils/app_settings.dart';
import 'authentication_event.dart';
import 'authentication_screen.dart';
import 'authentication_state.dart';

const identityServerTarget = "https://development-isse-identity-backend.azurewebsites.net";
const appIdentifier = "reconstructit.platform";
const baseRedirectUri = "com.example.reconstructitapp";

/// Redirect uri after successful authentication
 const authRedirectUri = "$baseRedirectUri://auth-callback";

/// Redirect uri after ending the user's session successfully
 const postLogoutRedirectUri = "$baseRedirectUri://logout-callback";
/// Top-Level bloc to manage the user's authentication status
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  /// Currently used grant
  /// Held as bloc member to validate passed grant later in redirect listener
  AuthorizationCodeGrant? _grant;

 // final RemoveSelectedOrganisation removeSelectedOrganisation;


  AuthenticationBloc()
    : super(AuthenticationIdle()) {
    // Start redirect listener
    // Set event handlers
    on<EnterApplication>(_onEnterApplication);
    on<Authenticate>(_onAuthenticate);
    on<SignOut>(_onSignOut);
    on<HandleAuthorizationResponse>(_handleAuthorizationResponse);
    on<HandleLogoutResponse>(_handleLogoutResponse);
  }

  void _handleAuthorizationResponse(
    HandleAuthorizationResponse event,
    emit,
  ) async {
    Uri responseUrl = Uri.parse(event.responseUrl);
    // Create client based on the redirect parameters
    Client client = await _grant!.handleAuthorizationResponse(
      responseUrl.queryParameters,
    );
    // Update local credentials
    String credentialsPath = await AppPathProvider.getCredentialsPath();
    await File(credentialsPath).writeAsString(client.credentials.toJson());
    // Dispose current grant
    _grant = null;
    // Exit authentication screen
    add(EnterApplication());
  }

  void _handleLogoutResponse(HandleLogoutResponse event, emit) async {
    // Get credentials path
    String credentialsPath = await AppPathProvider.getCredentialsPath();
    // Delete locally stored credentials
    await File(credentialsPath).delete();
    // Delete locally stored selected Organisation
    //await removeSelectedOrganisation.invoke(() {});
    // Dispose current grant
    _grant = null;
    // Require user sign in
    add(Authenticate());
  }

  void _onEnterApplication(event, emit) async {
    emit(AuthenticationSucceeded());
  }

  void _onSignOut(event, emit) async {
    String credentialsPath = await AppPathProvider.getCredentialsPath();
    // Get current credentials
    final credentialsFile = File(credentialsPath);
    var credentials = Credentials.fromJson(
      await credentialsFile.readAsString(),
    );
    if (credentials.isExpired) {
      credentials = await credentials.refresh(identifier: appIdentifier);
    }
    // Direct to end session page
    var uri = Uri.parse(
      "$identityServerTarget/connect/endsession?id_token_hint=${credentials.idToken}&post_logout_redirect_uri=$postLogoutRedirectUri",
    );

    emit(UserLogoutRequired(uri, Uri.parse(postLogoutRedirectUri)));
  }

  void _onAuthenticate(event, emit) async {
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
          // Delete local credentials
          await credentialsFile.delete();
          // When refresh token is expired, redirect to authentication
          Navigator.push(
            AppSettings.navigatorState.currentContext!,
            MaterialPageRoute(builder: (_) => const AuthenticationScreen()),
          );
        }

        // Update local credentials
        await File(credentialsPath).writeAsString(credentials.toJson());
      }
      // Trigger refreshes
      add(EnterApplication());
      return;
    }

    // Create authorization grant to create the authorization code
    _grant = AuthorizationCodeGrant(
      appIdentifier,
      Uri.parse(
        '$identityServerTarget/connect/authorize',
      ),
      Uri.parse('$identityServerTarget/connect/token'),
    );
    // Get authorization url from grant
    var authorizationUrl = _grant!.getAuthorizationUrl(
      Uri.parse(authRedirectUri),
      scopes: ["openid", "email", "offline_access"],
    );
    // emit state to open webview
    emit(UserSignInRequired(authorizationUrl, Uri.parse(authRedirectUri)));
  }
}
