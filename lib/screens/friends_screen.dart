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
                  FriendsUsernames(friendUsername: 'Brandon123'), // this will all change to a call to database
                  FriendsGyms(friendGyms: 'Gold\'s Gym'),
                  FriendImages(friendImage: 'images/Background 2.jpg')
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
        friendUsername, // you'll change this to something with flutter once we store friends
      ),
    );
  }
}

class FriendsGyms extends StatelessWidget {
  const FriendsGyms({
    super.key,
    required this.friendGyms,
  });

  final String friendGyms;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text (
        friendGyms, // you'll change this to something with flutter once we store friends
      ),
    );
  }
}

class FriendImages extends StatelessWidget {
  const FriendImages({
    super.key,
    required this.friendImage,
  });

  final String friendImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(60),
        child: CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(friendImage),
        ));
  }
}