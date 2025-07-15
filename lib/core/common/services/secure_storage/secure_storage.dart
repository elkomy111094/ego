import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ego/core/cache/cache_keys.dart';

class SecureStorage {

  static  String ? currentToken ;
  
  static Future<FlutterSecureStorage> get _instance async =>
      storage = const FlutterSecureStorage();
  static FlutterSecureStorage? storage;
  static Future<FlutterSecureStorage> initialize() async {
    storage = await _instance;
    return storage!;
  }

  static Future<String?> readString(String key) async {
    return await storage!.read(key: key);
  }

  static Future writeString(String key, var defValue) async {
    return storage?.write(key: key, value: defValue) ?? defValue ?? "";
  }

  static Future deleteString(String key) async {
    var delete = await storage!.delete(key: key);
    return delete;
  }


 

  Future<void> saveToken(String token) async {
    await writeString(PrefKeys.accessToken, token);
  }

  Future<String?> getToken() async {
     currentToken = await readString(PrefKeys.accessToken);
  }

  Future<void> deleteToken() async {
    await deleteString(PrefKeys.accessToken);
  }
}
