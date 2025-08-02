import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageHelper {
  // Create storage object
  // This object is used to interact with secure storage
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  // Write token to secure storage
  // This method saves the token securely in the device storage
  Future saveData({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  // Read token from secure storage
  // This method retrieves the token from the secure storage
  Future<String?> getData({required String key}) async {
    return await storage.read(key: key);
  }

  // Delete token from secure storage
  // This method removes the token from the secure storage
  Future deleteData({required String key}) async {
    await storage.delete(key: key);
  }
}
