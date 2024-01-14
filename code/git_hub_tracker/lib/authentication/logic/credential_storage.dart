import 'package:oauth2/oauth2.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

///SecureStorage to store the credentials when already signedIn
class CredentialStorage{

  ///Reference to a SecureStorage
  late final FlutterSecureStorage _storage;

  ///The CachedCredentials
  Credentials? _cacheCred;

  ///The mapKey to Store Credentials
  static const _storageKey = 'OAuth2_Credentials';

  ///Default Constructor
  CredentialStorage(){
    _storage = const FlutterSecureStorage();
  }

  ///Read the Credentials
  Future<Credentials?> read() async {
    //If cache is null, try to get the cred in secure storage
    if(_cacheCred == null)
    {
      final json = await _storage.read(key: _storageKey);

      if(json == null) return null;
      try
      {
        _cacheCred = Credentials.fromJson(json);
      }
      on FormatException {
        return null;
      }
    }

    return _cacheCred;
  }

  ///Write the Credentials
  Future<void> save(Credentials credentials) async {
    _cacheCred = credentials;
    return _storage.write(key: _storageKey, value: credentials.toJson());
  }

  ///Clear the Credentials
  Future<void> clear() async {
    _cacheCred = null;
    _storage.delete(key: _storageKey);
  }
}