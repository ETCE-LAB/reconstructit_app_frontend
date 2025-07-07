import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oauth2/oauth2.dart';
import 'package:path_provider/path_provider.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';


const identityServerTarget =
    "https://dev.backend.isse-identity.com";
const appIdentifier = "reconstructit.platform";
const baseRedirectUri = "com.example.reconstructitapp";

/// Redirect uri after successful authentication
const authRedirectUri = "$baseRedirectUri://auth-callback";


/// Bloc to manage the user's authentication status
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationIdle()) {
    on<PrepareAuthenticationRedirect>(_onPrepareAuthenticationRedirect);
    on<FetchCredentials>(_onFetchCredentials);
  }

  void _onPrepareAuthenticationRedirect(event, emit) async {
    final authorizationEndpoint = Uri.parse(
      '$identityServerTarget/connect/authorize',
    );
    final tokenEndpoint = Uri.parse('$identityServerTarget/connect/token');

    // final secret = '499e17f9-5c3a-420b-b724-e0b79170e03c';
    // Create authorization grant to create the authorization code
    final grant = AuthorizationCodeGrant(
      appIdentifier,
      authorizationEndpoint,
      tokenEndpoint,
      // secret: secret,
    );

    final redirectUrl = Uri.parse(authRedirectUri);
    // Get authorization url from grant
    var authorizationUrl = grant.getAuthorizationUrl(
      redirectUrl,
      scopes: ["platform", "offline_access"],
    );

    emit(RedirectedToIdentityServer(grant, authorizationUrl, redirectUrl));
  }

  void _onFetchCredentials(FetchCredentials event, emit) async {
    emit(FetchingCredentials());
    print("try to fetch credentials");
    // Create client based on the redirect parameters
    final client = await event.currentGrant.handleAuthorizationResponse(
      event.responseUrl.queryParameters,
    );
    // Get credentials
    final credentials = client.credentials;
    // Update local credentials
    var docDir = await getApplicationDocumentsDirectory();
    final credentialsPath = '${docDir.path}/credentials.json';
    await File(credentialsPath).writeAsString(credentials.toJson());

    emit(AuthenticationSucceeded());
  }
}


/*
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
 */
