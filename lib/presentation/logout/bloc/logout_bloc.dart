import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oauth2/oauth2.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../utils/clients/app_path_provider.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import 'logout_event.dart';
import 'logout_state.dart';

/// Top-Level bloc to manage the user's authentication status
class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {

  /// Redirect uri after ending the user's session successfully
  static const postLogoutRedirectUri = "$baseRedirectUri://logout-callback";

  LogoutBloc() : super(LogoutIdle()) {
    // Set event handlers
    on<PrepareLogoutRedirect>(_onPrepareLogoutRedirect);
    on<RemoveCredentials>(_onRemoveCredentials);
  }

  void _onPrepareLogoutRedirect(event, emit) async {
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

    emit(RedirectedToIdentityServer(uri, Uri.parse(postLogoutRedirectUri)));
  }

  void _onRemoveCredentials(RemoveCredentials event, emit) async {
    emit(RemovingCredentials());
    // Update local credentials
    var docDir = await getApplicationDocumentsDirectory();
    final credentialsPath = '${docDir.path}/credentials.json';

    // Delete locally stored credentials
    await File(credentialsPath).delete();

    emit(LogoutSucceeded());
  }
}
