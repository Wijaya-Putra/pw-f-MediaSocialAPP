import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
/*

Database to store posts that the user have posted in the app
Stored in a collection called "Posts" in Firebase

Post contain"
- Message
- Email of user
- Timestamp

*/

class FirestoreDatabase {
  // Current logged in user
  User? user = FirebaseAuth.instance.currentUser;

  // Get Posts
  final CollectionReference posts =
      FirebaseFirestore.instance.collection("Posts");

  // Post Message
  Future<void> addPost(String message) {
    return posts.add({
      'UserEmail': user!.email,
      'postMessage': message,
      'TimeStamp': Timestamp.now()
    });
  }

  // Read Post from DB
  Stream<QuerySnapshot> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
        .collection("Posts")
        .orderBy("TimeStamp", descending: true)
        .snapshots();

    return postsStream;
  }
}
