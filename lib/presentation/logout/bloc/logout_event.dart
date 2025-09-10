abstract class LogoutEvent {}

/// Event to trigger the authentication process
class PrepareLogoutRedirect extends LogoutEvent {}

/// Event to fetch user credentials (with access token etc.) after
/// IdentityServer redirect to the app
class RemoveCredentials extends LogoutEvent {
  RemoveCredentials();
}
