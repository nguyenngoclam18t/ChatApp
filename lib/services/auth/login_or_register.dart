import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool isShowLogin = true;
  void toggleLogin() {
    setState(() {
      isShowLogin = !isShowLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isShowLogin
        ? LoginPage(
            toggleLogin: toggleLogin,
          )
        : RegisterPage(
            toggleLogin: toggleLogin,
          );
  }
}
