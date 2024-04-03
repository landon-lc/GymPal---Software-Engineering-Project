// import 'package:firebase_auth/firebase_auth.dart'; going to be used in the future
import 'package:flutter/material.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: SingleChildScrollView(
                child: Column(children: [
                  FriendsUsernames(friendUsername: 'Brandon123')
            ]
          )
        )
      )
    );
  }
}

// Used for displaying friends usernames, don't really know how 
class FriendsUsernames extends StatelessWidget {
  const FriendsUsernames({
    super.key,
    required this.friendUsername,
  });

  final String friendUsername;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text (
        friendUsername,
      ),
    );
  }
}
