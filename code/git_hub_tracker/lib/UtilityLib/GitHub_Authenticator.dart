import 'package:flutter/services.dart';
import 'package:git_hub_tracker/UtilityLib/CredentialStorage.dart';
import 'package:oauth2/oauth2.dart';

class GitHubAuthenticator {
  late final CredentialStorage _credentialStorage;

  Future<Credentials?> getSignedInCredentials() async {
    try
    {
      final storedCredentials = await _credentialStorage.read();
      if(storedCredentials != null)
      {
        if(storedCredentials.canRefresh && storedCredentials.isExpired)
        {
          //todo: Refresh the token
        }
      }
      return storedCredentials;
    }
    on PlatformException{
      return null;
    }
  }

  Future<bool> isSignedIn() => getSignedInCredentials().then((credentials) => credentials != null);
}