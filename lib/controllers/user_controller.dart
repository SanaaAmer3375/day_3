import '../services/storage_service.dart';

class UserController {

  final StorageService storageService = StorageService();

  Future<void> addUser(String name, String password) async {
    await storageService.saveUser(name, password);
  }

  Future<List<Map<String,String>>> getUsers() async {

    final data = await storageService.getUsers();

    List<Map<String,String>> users = [];

    data.forEach((key,value){

      var parts = value.split(",");

      users.add({
        "name": parts[0],
        "password": parts[1]
      });

    });

    return users;
  }
}
