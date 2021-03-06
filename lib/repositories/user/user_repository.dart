import 'dart:async';
import 'dart:developer';
import 'package:flutter_login/common/storage/secure_storage.dart';

import '../../models/user/bucket.dart';

class UserRepository {
  User _user;
  final SecureStorage _secureStorage = SecureStorage();

  Future<void> deleteToken() async {
    return await _secureStorage.deleteSecureData('token');
  }

  Future<void> deleteRefreshToken() async {
    return await _secureStorage.deleteSecureData('refreshToken');
  }

  Future<void> persistUserCredentials(Map<String, String> credentials) async {
    /// write to keystore/keychain
    return await _secureStorage.writeSecureDataMap(credentials);
  }

  Future<bool> hasToken() async {
    return await _secureStorage.readSecureData('token') != null;
  }

  Future<String> getToken() async {
    return await _secureStorage.readSecureData('token');
  }

  Future<String> getRefreshToken() async {
    return await _secureStorage.readSecureData('refreshToken');
  }

  Future<User> getUser() async {
    var _user = await _secureStorage.readAllSecureData().then((credentials) =>
        credentials['token'] != null
            ? const User(id: 1, name: '', imageUrl: '')
            : null);
    return _user;
  }
}
