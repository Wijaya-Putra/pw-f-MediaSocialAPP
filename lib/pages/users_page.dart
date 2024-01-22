import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pw_socialmediaapp/components/my_list_tile.dart';
import 'package:pw_socialmediaapp/helper/helper_functions.dart';
import 'package:pw_socialmediaapp/components/my_backbutton.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          // Error
          if (snapshot.hasError) {
            displayPopupMessage("Something Went Wrong", context);
          }

          // Loading Circle
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // No Data
          if (snapshot.data == null) {
            return const Center(
              child: Text("No Data"),
            );
          }

          // Get all users
          final users = snapshot.data!.docs;

          return Column(
            children: [
              // Back Button
              const Padding(
                padding: EdgeInsets.only(top: 50, left: 25),
                child: Row(
                  children: [
                    MyBackButton(),
                  ],
                ),
              ),

              // List of users in the App
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      // Get Individual Users
                      final user = users[index];

                      // Get data from each user
                      String Username = user["username"];
                      String Email = user["email"];

                      return MyListTile(title: Username, subTitle: Email);
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
}
