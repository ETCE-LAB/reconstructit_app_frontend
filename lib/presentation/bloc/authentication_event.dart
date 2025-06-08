abstract class AuthenticationEvent {}

/// Starts the authentication process
class Authenticate extends AuthenticationEvent {}

class SignOut extends AuthenticationEvent {}

class EnterApplication extends AuthenticationEvent {}

class HandleAuthorizationResponse extends AuthenticationEvent{
  final String responseUrl;
  HandleAuthorizationResponse(this.responseUrl);
}

class HandleLogoutResponse extends AuthenticationEvent {}