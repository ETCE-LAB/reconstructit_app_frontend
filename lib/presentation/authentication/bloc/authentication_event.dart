import 'package:oauth2/oauth2.dart';

abstract class AuthenticationEvent {}

/// Event to trigger the authentication process
class PrepareAuthenticationRedirect extends AuthenticationEvent {}

/// Event to fetch user credentials (with access token etc.) after
/// IdentityServer redirect to the app
class FetchCredentials extends AuthenticationEvent {
  final AuthorizationCodeGrant currentGrant;
  final Uri responseUrl;

  FetchCredentials(this.currentGrant, this.responseUrl);
}
