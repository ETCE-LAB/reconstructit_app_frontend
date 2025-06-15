import 'package:oauth2/oauth2.dart';

abstract class AuthenticationState {}

class AuthenticationIdle extends AuthenticationState {}

class RedirectedToIdentityServer extends AuthenticationState {
  final AuthorizationCodeGrant currentGrant;
  final Uri authorizationUrl;
  final Uri redirectUrl;

  RedirectedToIdentityServer(
      this.currentGrant,
      this.authorizationUrl,
      this.redirectUrl,
      );
}

class FetchingCredentials extends AuthenticationState {}

class AuthenticationSucceeded extends AuthenticationState {}

class AuthenticationFailed extends AuthenticationState {}
