import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pw_socialmediaapp/components/my_drawer.dart';
import 'package:pw_socialmediaapp/components/my_list_tile.dart';
import 'package:pw_socialmediaapp/components/my_post_Button.dart';
import 'package:pw_socialmediaapp/components/my_textfield.dart';
import 'package:pw_socialmediaapp/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Firestore access
  final FirestoreDatabase database = FirestoreDatabase();

  // Controllers
  final TextEditingController newPostController = TextEditingController();

  // Post Message
  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }

    // Clear Controller
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("T h e  A p p"),
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.inversePrimary),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          // Textfield Box to Type
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                // Textfield
                Expanded(
                  child: MyTextfield(
                      hintText: "Let your thoughts fly",
                      obscureText: false,
                      controller: newPostController),
                ),

                // Post Butotn
                PostButton(onTap: postMessage)
              ],
            ),
          ),

          // Posts
          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              // Loading Circle
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              // Get all posts
              final posts = snapshot.data!.docs;

              // No Posts
              if (snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Text("No Posts.. Post Something!"),
                );
              }

              // Return List of Posts
              return Expanded(
                  child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        // Get Every Posts
                        final post = posts[index];

                        // Get data from each post
                        String message = post['postMessage'];
                        String userEmail = post['UserEmail'];
                        Timestamp timestamp = post['TimeStamp'];

                        // Return as a list tile
                        return MyListTile(title: message, subTitle: userEmail);
                      }));
            },
          )
        ],
      ),
    );
  }
}
