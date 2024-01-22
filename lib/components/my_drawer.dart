import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // Log out
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // Header
              DrawerHeader(
                  child: Icon(
                Icons.favorite_rounded,
                color: Theme.of(context).colorScheme.inversePrimary,
              )),

              // Home
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: Text(
                      " H O M E ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.pushNamed(context, '/home_page');
                    }),
              ),

              // Profile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: Text(
                      " P R O F I L E ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.pushNamed(context, '/profile_page');
                    }),
              ),

              // Users
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                    leading: Icon(
                      Icons.group,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: Text(
                      " U S E R S ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.pushNamed(context, '/users_page');
                    }),
              ),
            ],
          ),

          // Logout
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 50),
            child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: Text(
                  " L O G   O U T ",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                onTap: () {
                  logout();
                  Navigator.pop(context);
                }),
          ),
        ],
      ),
    );
  }
}
