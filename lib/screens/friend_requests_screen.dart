import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'profile_editor_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'friends_screen.dart';

class FriendRequestsScreen extends StatelessWidget { 
  const FriendRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double containerWidth = 400; // Change this when changing the containers height and width
    double containerHeight = 300;

    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
            padding: const EdgeInsets.all(1),
        ),
    );
  }
}

class friendsMySquare extends StatelessWidget {
  const friendsMySquare({super.key});

  // This is used to define the square for each section of the list
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Container(
          height: 20,
          color: Colors
              .deepPurple, // color can change, just a random color I chose
        ));
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FriendsScreen()));
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          child: const Text('Back',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ));
  }
}