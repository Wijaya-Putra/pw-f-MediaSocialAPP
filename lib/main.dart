import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pw_socialmediaapp/auth/auth.dart';
import 'package:pw_socialmediaapp/auth/login_register.dart';
import 'package:pw_socialmediaapp/firebase_options.dart';
import 'package:pw_socialmediaapp/pages/home_page.dart';
import 'package:pw_socialmediaapp/pages/profile_page.dart';
import 'package:pw_socialmediaapp/pages/users_page.dart';
import 'package:pw_socialmediaapp/theme/dark_mode.dart';
import 'package:pw_socialmediaapp/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      routes: {
        '/login_register_page': (context) => const LoginOrRegister(),
        '/home_page': (context) => HomePage(),
        '/profile_page': (context) => ProfilePage(),
        '/users_page': (context) => const UsersPage(),
      },
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
