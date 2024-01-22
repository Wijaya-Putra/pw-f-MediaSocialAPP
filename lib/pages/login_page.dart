import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pw_socialmediaapp/components/my_button.dart';
import 'package:pw_socialmediaapp/components/my_textfield.dart';
import '../helper/helper_functions.dart';

class LoginPage extends StatefulWidget {
  final void Function()? ontap;

  const LoginPage({super.key, required this.ontap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Functions
  void login() async {
    // Loading Circle
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    // Try Sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      displayPopupMessage(e.code, context);
    }
  }

  // Controller
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Icon(
                    Icons.person,
                    size: 80,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),

                  const SizedBox(height: 15),

                  // Title
                  const Text(
                    "S O C I A L",
                    style: TextStyle(fontSize: 20),
                  ),

                  const SizedBox(height: 25),

                  // Textfield : Email
                  MyTextfield(
                      hintText: "Email",
                      obscureText: false,
                      controller: emailController),

                  const SizedBox(height: 10),

                  // Textfield : Password

                  MyTextfield(
                      hintText: "Password",
                      obscureText: true,
                      controller: passwordController),

                  const SizedBox(height: 10),

                  // Forgot Password?

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Forgot Password ? ",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary)),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // Button : Sign in
                  MyButton(text: "Sign In", ontap: login),

                  const SizedBox(height: 25),

                  //  Dont have account?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(" Don't have an account? "),
                      GestureDetector(
                        onTap: widget.ontap,
                        child: const Text(
                          " Register Here ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
