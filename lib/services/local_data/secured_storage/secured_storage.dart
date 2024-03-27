import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecuredStorage {
  final _storage = const FlutterSecureStorage();

  Future<void> save({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> get(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
