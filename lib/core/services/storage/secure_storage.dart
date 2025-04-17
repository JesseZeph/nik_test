import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _secureStore;

  SecureStorageService(FlutterSecureStorage store) : _secureStore = store;

  writeData(String key, String value) async =>
      await _secureStore.write(key: key, value: value);
  Future<String?> readData(String key) async =>
      await _secureStore.read(key: key);
  void deleteData(String key) async => await _secureStore.delete(key: key);

  Future<void> clearStore() async => await _secureStore.deleteAll();
}
