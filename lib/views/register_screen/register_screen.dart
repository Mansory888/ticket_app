import 'package:flutter/material.dart';
import '../../services/api/user_service.dart';
import '../../generated/l10n.dart';
import '../../models/user.dart';

class RegisterScreenWidget extends StatefulWidget {
  const RegisterScreenWidget({super.key});

  @override
  State<RegisterScreenWidget> createState() => _RegisterScreenWidget();
}

class _RegisterScreenWidget extends State<RegisterScreenWidget> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> register() async {
    User user = User(
      username: usernameController.text,
      password: passwordController.text,
      email: emailController.text,
    );

    try {
      if (usernameController.text.isEmpty ||
          emailController.text.isEmpty ||
          passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red, // Change this to your desired color
            content: Text(
              'All fields are required!',
              style: TextStyle(
                fontSize: 18.0, // Adjust the font size here
              ),
            ),
          ),
        );
      } else {
        final registeredUserMap = await registerUser(user.toJson());
        print('User registered successfully:' + registeredUserMap.toString());
        Navigator.pop(context);
      }

      // Handle the success scenario, e.g., navigate to another screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red, // Change this to your desired color
          content: Text(
            '$e',
            style: const TextStyle(
              fontSize: 18.0, // Adjust the font size here
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          toolbarHeight: 40.0,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, top: 40),
            child: Text(
              S.of(context).RegisterAccount,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30),
            child: Text(
              S.of(context).fillDetails,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                labelStyle:
                    const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(106, 106, 106, 106), width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 2.0),
                ),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(left: 15, right: 15, top: 30),
              child: TextField(
                controller: usernameController,
                obscureText: false,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person,
                      color: Color.fromARGB(
                          106, 106, 106, 100)), // Color for the icon
                  labelText: S.of(context).UserName,
                ),
              ),
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                labelStyle:
                    const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(106, 106, 106, 106), width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 2.0),
                ),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                controller: emailController,
                obscureText: false,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email,
                      color: Color.fromARGB(
                          106, 106, 106, 100)), // Color for the icon
                  labelText: S.of(context).emailAdress,
                ),
              ),
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                labelStyle:
                    const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(106, 106, 106, 106), width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 2.0),
                ),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock,
                      color: Color.fromARGB(
                          106, 106, 106, 100)), // Color for the icon
                  labelText: S.of(context).password,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 40),
              child: ElevatedButton(
                onPressed: () {
                  register();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  minimumSize: const Size(325, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  S.of(context).Register,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Text(
                  S.of(context).AlreadyHaveAccount,
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30, left: 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    S.of(context).LogIn,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
