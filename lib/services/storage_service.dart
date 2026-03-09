import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> saveUser(String name, String password) async {

    String value = "$name,$password";

    await storage.write(
      key: DateTime.now().toString(),
      value: value,
    );
  }

  Future<Map<String,String>> getUsers() async {
    return await storage.readAll();
  }

}
