import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../services/api/user_service.dart';
import '../../generated/l10n.dart';

class LoginScreenWidget extends StatefulWidget {
  const LoginScreenWidget({super.key});

  @override
  State<LoginScreenWidget> createState() => _LoginScreenWidget();
}

class _LoginScreenWidget extends State<LoginScreenWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    User user = User(
      username: "",
      password: passwordController.text,
      email: emailController.text,
    );
    try {
      final login = await loginUser(user.toJson());

      if (login.containsKey('token')) {
        await persistUserData(
          login['token'],
          login['username'],
          login['email'],
          login['language_id'],
          login['id'],
        );

        print('User logged successfully:' + login.toString());
        Navigator.pushReplacementNamed(context, '/main');
      }
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // This will prevent the pop (going back) action.
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          shadowColor: Colors.transparent,
          toolbarHeight: 40.0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, top: 40),
              child: Text(
                S.of(context).welcomeBack,
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
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(106, 106, 106, 106), width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2.0),
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 15, right: 15, top: 30),
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
                        color: Theme.of(context).colorScheme.primary,
                        width: 2.0),
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
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: const EdgeInsets.only(right: 30),
                child: Text(
                  S.of(context).forgotPassword,
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 40),
                child: ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    minimumSize: const Size(325, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    S.of(context).LogIn,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    S.of(context).newUser,
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 5),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      S.of(context).CreateAccount,
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
      ),
    );
  }
}
