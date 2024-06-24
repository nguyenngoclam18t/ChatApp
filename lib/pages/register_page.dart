import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_snackbar.dart';
import '../components/my_textfiled.dart';
import '../services/auth/auth_service.dart';

class RegisterPage extends StatelessWidget {
  final usernameTextController = TextEditingController();
  final passTextController = TextEditingController();
  final confirmPassTextController = TextEditingController();
  final void Function()? toggleLogin;
  RegisterPage({super.key, required this.toggleLogin});

  void register(BuildContext context) async {
    if (confirmPassTextController.text.isEmpty ||
        passTextController.text.isEmpty ||
        usernameTextController.text.isEmpty) {
      MySnackbar.showMySnackBar(
          context, "Lỗi Đăng Ký", "điền đầy đủ thông tin", ContentType.failure);

      return;
    }
    if (confirmPassTextController.text != passTextController.text) {
      MySnackbar.showMySnackBar(context, "Lỗi Đăng Ký",
          "mật khẩu nhập không trùng", ContentType.failure);

      return;
    }
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    final auth = AuthService();
    try {
      await auth.registerWithEmailAndPassword(
          usernameTextController.text, passTextController.text);
      Navigator.pop(context);
      MySnackbar.showMySnackBar(
          context,
          "Đăng ký thành công",
          "Bạn đã đăng ký thành công hãy tận hưởng ứng dụng",
          ContentType.success);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      MySnackbar.showMySnackBar(
          context, "Lỗi đăng ký", e.code, ContentType.failure);
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
              "Create account now, chat now",
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
              height: 10,
            ),
            MyTextfiled(
              hintText: "Confirmpassword",
              obscureText: true,
              controller: confirmPassTextController,
            ),
            const SizedBox(
              height: 25,
            ),
            MyButton(
              text: "Register",
              onTap: () => register(context),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "have an account?? ",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: toggleLogin,
                  child: Text(
                    "Login now ",
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
