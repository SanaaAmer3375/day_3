import 'package:flutter/material.dart';
import '../controllers/user_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final nameController = TextEditingController();
  final passController = TextEditingController();

  final UserController userController = UserController();

  List<Map<String,String>> users = [];

  void loadUsers() async {
    users = await userController.getUsers();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  void addUser() async {

    await userController.addUser(
      nameController.text,
      passController.text,
    );

    nameController.clear();
    passController.clear();

    loadUsers();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Data Saved Successfully"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Secure Storage"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: passController,
              decoration: InputDecoration(
                labelText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                  )
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: addUser,
              child: const Text("Login"),
            ),

            const SizedBox(height: 20, width: 70,),

            Expanded(
              child: ListView.builder(
                itemCount: users.isEmpty ? 0 : 1,
                itemBuilder: (context, index) {
                  var lastUser = users.last;
                  return ListTile(
                    title: Text(lastUser["name"]!),
                    subtitle: Text(lastUser["password"]!),
                  );
                },
              ),
            )


          ],

        ),
      ),
    );
  }
}
