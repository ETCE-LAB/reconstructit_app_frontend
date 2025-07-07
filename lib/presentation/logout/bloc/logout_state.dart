abstract class LogoutState {}

class LogoutIdle extends LogoutState {}

class RedirectedToIdentityServer extends LogoutState {
  final Uri logoutUrl;
  final Uri redirectUrl;

  RedirectedToIdentityServer(this.logoutUrl, this.redirectUrl);
}

class RemovingCredentials extends LogoutState {}

class LogoutSucceeded extends LogoutState {}

class LogoutFailed extends LogoutState {}
