import 'package:flutter/material.dart';
import 'package:pw_socialmediaapp/pages/login_page.dart';
import 'package:pw_socialmediaapp/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // Intially show login Page
  bool showLoginPage = true;

  // Toggle between login or register
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(ontap: togglePages);
    } else {
      return RegisterPage(ontap: togglePages);
    }
  }
}
