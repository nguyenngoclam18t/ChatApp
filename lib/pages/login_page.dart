import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_textfiled.dart';
import '../services/auth/auth_service.dart';

class LoginPage extends StatelessWidget {
  void Function()? toggleLogin;
  LoginPage({super.key, required this.toggleLogin});

  final usernameTextController = TextEditingController();
  final passTextController = TextEditingController();
  void login(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    final auth = AuthService();
    try {
      await auth.signinWithEmailAndPassword(
          usernameTextController.text, passTextController.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      MySnackbar.showMySnackBar(
          context, "Lỗi đăng nhập", e.code, ContentType.failure);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //logo
            Icon(
              Icons.message,
              size: 70,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Welcome back, you've been missed",
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(
              height: 25,
            ),
            MyTextfiled(
              hintText: "test@gmail.com",
              obscureText: false,
              controller: usernameTextController,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextfiled(
              hintText: "password",
              obscureText: true,
              controller: passTextController,
            ),
            const SizedBox(
              height: 25,
            ),
            MyButton(
              text: "Login",
              onTap: () => login(context),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Not a member? ",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: toggleLogin,
                  child: Text(
                    "Register now ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
