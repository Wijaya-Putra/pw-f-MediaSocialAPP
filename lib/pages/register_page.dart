import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pw_socialmediaapp/components/my_button.dart';
import 'package:pw_socialmediaapp/components/my_textfield.dart';
import '../helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? ontap;

  const RegisterPage({super.key, required this.ontap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controller
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();

  // Functions
  void register() async {
    // Loading Circle
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    // Match Password
    if (passwordController.text != confirmpasswordController.text) {
      Navigator.pop(context);

      displayPopupMessage("Password don't Match", context);
    } else {
      // Try create new user
      try {
        // Create user
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        // Store user data to UserDocument
        createUserDocument(userCredential);
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);

        displayPopupMessage(e.code, context);
      }
    }
  }

  // Create a user document and collect them in firestore
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': usernameController.text
      });
    }
  }

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
                    size: 70,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),

                  const SizedBox(height: 10),

                  // Title
                  const Text(
                    "S O C I A L",
                    style: TextStyle(fontSize: 20),
                  ),

                  const SizedBox(height: 25),

                  // Textfield : Username
                  MyTextfield(
                      hintText: "Username",
                      obscureText: false,
                      controller: usernameController),

                  const SizedBox(height: 10),

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

                  // Textfield : Confirm Passowrd
                  MyTextfield(
                      hintText: "Confirm Password",
                      obscureText: true,
                      controller: confirmpasswordController),

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

                  // Button : Register
                  MyButton(text: "Register", ontap: register),

                  const SizedBox(height: 25),

                  //  Dont have account?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(" Already have an account? "),
                      GestureDetector(
                        onTap: widget.ontap,
                        child: const Text(
                          " Sign In Here ",
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
