import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  Future writeSecureData(String key, String value) async {
    return await _storage.write(key: key, value: value);
  }

  Future writeSecureDataMap(Map<String, String> data) async {
    return data.forEach((key, value) async {
      await _storage.write(key: key, value: value);
    });
  }

  Future<String> readSecureData(String key) async {
    return await _storage.read(key: key);
  }

  Future deleteSecureData(String key) async {
    return await _storage.delete(key: key);
  }

  Future<Map<String, String>> readAllSecureData() async {
    return await _storage.readAll();
  }

  Future<Map> readSelectedSecureData(List<String> data) async {
    var _map = <String, String>{};
    data.forEach((key) async {
      _map[key] = await _storage.read(key: key);
    });
    return _map;
  }
}
