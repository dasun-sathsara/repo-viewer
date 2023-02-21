import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oauth2/oauth2.dart';
import './credentials_storage.dart';

class SecureCredentialStorage implements CredentialStorage {
  SecureCredentialStorage(this._storage);

  final FlutterSecureStorage _storage;
  static const _key = 'oauth2_credentials';
  Credentials? _cachedCredentials;

  @override
  Future<void> save(Credentials credentials) {
    _cachedCredentials = credentials;
    return _storage.write(key: _key, value: credentials.toJson());
  }

  @override
  Future<Credentials?> read() async {
    if (_cachedCredentials != null) {
      return _cachedCredentials;
    }

    final credentialsJson = await _storage.read(key: _key);
    if (credentialsJson == null) {
      return null;
    }

    try {
      _cachedCredentials = Credentials.fromJson(credentialsJson);
      return _cachedCredentials;
    } on FormatException {
      return null;
    }
  }

  @override
  Future<void> clear() async {
    _cachedCredentials = null;
    _storage.delete(key: _key);
  }
}
