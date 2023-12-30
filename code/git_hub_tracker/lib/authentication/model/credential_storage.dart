import 'package:oauth2/oauth2.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CredentialStorage{
  final FlutterSecureStorage _storage;
  Credentials? _cacheCred;

  static const _storageKey = 'OAuth2_Credentials';

  CredentialStorage(this._storage);

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

  Future<void> save(Credentials credentials) async {
    _cacheCred = credentials;
    return _storage.write(key: _storageKey, value: credentials.toJson());
  }

  Future<void> clear() async {
    _cacheCred = null;
    _storage.delete(key: _storageKey);
  }
}