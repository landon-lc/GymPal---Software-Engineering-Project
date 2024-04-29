import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FriendsProfileScreen extends StatefulWidget {
  final Map<dynamic, dynamic> user;

  const FriendsProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  _FriendsProfileScreenState createState() => _FriendsProfileScreenState();
}

class _FriendsProfileScreenState extends State<FriendsProfileScreen> {
  bool isFriendAdded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user['username']),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Text('Bio: ${widget.user['bio']}')),
            Expanded(child: Text('Email: ${widget.user['email']}')),
            Expanded(child: Text('Favorite Gym: ${widget.user['favGym']}')),
            SizedBox(height: 20),
            Visibility(
              visible: !isFriendAdded,
              child: ElevatedButton(
                onPressed: () {
                  _addFriend();
                },
                child: Text('Add Friend'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addFriend() async {
    final currentUserID = FirebaseAuth.instance.currentUser!.uid;
    DatabaseReference _dbRef = FirebaseDatabase.instance.ref('users');
    DatabaseReference currentUserRef = _dbRef.child(currentUserID);

    try {
      // Wait for the result of once() using await
      DatabaseEvent event = await currentUserRef.child('friends').once();
      DataSnapshot snapshot = event.snapshot;
      
      // Check if the friend's ID already exists in the friend list
      bool isFriendAlreadyAdded = false;
      if (snapshot.value != null) {
        Map<dynamic, dynamic>? friends = snapshot.value as Map<dynamic, dynamic>?; // Cast snapshot.value
        if (friends != null) {
          friends.forEach((key, value) {
            if (value == widget.user['UID']) {
              isFriendAlreadyAdded = true;
            }
          });
        }
      }

      if (!isFriendAlreadyAdded) {
        // Add friend's ID to current user's friends list
        await currentUserRef.child('friends').push().set(widget.user['UID']);
        // Add current user's ID to the friend's friend list
        DatabaseReference friendRef = _dbRef.child(widget.user['UID']);
        await friendRef.child('friends').push().set(currentUserID);
        setState(() {
          isFriendAdded = true; // Update the state to hide the button
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Friend added successfully!'),
          ),
        );
      } else {
        setState(() {
          isFriendAdded = true; // Update the state to hide the button
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Friend already added!'),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }
}
