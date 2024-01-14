import 'package:flutter/services.dart';
import 'package:git_hub_tracker/Core/constants/secret_consts.dart';
import 'package:git_hub_tracker/core/logic/utils/string_to_base64.dart';
import 'package:oauth2/oauth2.dart';
import 'package:dio/dio.dart';

import 'credential_storage.dart';
import 'github_oauth_http_client.dart';

typedef AuthUriCallback = Future<Uri> Function(Uri authorizationUrl);

///SingleTon
final GitHubAuthenticator authenticator = GitHubAuthenticator(CredentialStorage(), Dio());


/// Class that manage the Authentication on Github API
class GitHubAuthenticator {
  late final CredentialStorage _credentialStorage;
  late final Dio _dio;

  /// Constructor
  GitHubAuthenticator(this._credentialStorage, this._dio);


  /// Check if user is SignedIn
  Future<bool> isSignedIn() => getSignedInCredentials().then((credentials) => credentials != null);


  /// used to signIn on the GithubAPI
  Future<void> signIn(AuthorizationCodeGrant grant, Map<String, String> redirectUrl) async {
    final httpClient = await grant.handleAuthorizationResponse(redirectUrl);
    await _credentialStorage.save(httpClient.credentials);
    grant.close();
  }


  /// used to signOut of GithubAPI
  Future<void> signOut() async {
    final accessToken = await _credentialStorage.read().then((credentials) => credentials?.accessToken);
    final userPass = stringToBase64.encode('${SecretConsts.clientId}:${SecretConsts.clientSecret}');

    _dio.deleteUri(
      SecretConsts.revocationEndpoint,
      data: {
        'access_token': accessToken,
      },
      options: Options(
        headers: {
          'Authorization':'basic $userPass',
        }
      ),
    );

    await _credentialStorage.clear();
  }


  /// return null or Credentials
  Future<Credentials?> getSignedInCredentials() async {
    try
    {
      Credentials? storedCredentials = await _credentialStorage.read();

      //If the current token need to be refreshed:
      if(storedCredentials != null)
      {
        if(storedCredentials.canRefresh && storedCredentials.isExpired)
        {
          storedCredentials = await storedCredentials.refresh(
            identifier: SecretConsts.clientId,
            secret: SecretConsts.clientSecret,
            httpClient: GitHubOAuthHttpClient(),
          );
          await _credentialStorage.save(storedCredentials);
        }
      }

      return storedCredentials;
    }
    on PlatformException{
      return null;
    }
  }
}