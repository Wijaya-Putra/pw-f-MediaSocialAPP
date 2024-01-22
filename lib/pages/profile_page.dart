import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pw_socialmediaapp/components/my_backbutton.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // Current logged in user

  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Future to fetch user details

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error
          else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          // Data
          else if (snapshot.hasData) {
            // Extract Data
            Map<String, dynamic>? user = snapshot.data!.data();

            return Center(
              child: Column(
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

                  const SizedBox(
                    height: 25,
                  ),

                  // Profile Pic
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(24)),
                    padding: const EdgeInsets.all(25),
                    child: const Icon(
                      Icons.person,
                      size: 64,
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // Username
                  Text(
                    user!['username'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // Email
                  Text(
                    user['email'],
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("No Data"));
          }
        },
      ),
    );
  }
}
