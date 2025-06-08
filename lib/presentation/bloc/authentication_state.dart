
abstract class AuthenticationState {}

class AuthenticationIdle extends AuthenticationState {}

class AuthenticationFailed extends AuthenticationState {
  final Exception failure;
  AuthenticationFailed(this.failure);
}

class UserSignInRequired extends AuthenticationState{
  final Uri authorizationUrl;
  final Uri redirectUrl;
  UserSignInRequired(this.authorizationUrl, this.redirectUrl);
}

class UserLogoutRequired extends AuthenticationState{
  final Uri logoutUrl;
  final Uri redirectUrl;
  UserLogoutRequired(this.logoutUrl, this.redirectUrl);
}

class AuthenticationSucceeded extends AuthenticationState {}
