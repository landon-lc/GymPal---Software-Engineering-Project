// import 'package:firebase_auth/firebase_auth.dart'; going to be used in the future
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:firebase_database/firebase_database.dart'; will be used for calling friends info from database
// import 'package:firebase_auth/firebase_auth.dart';
// import '../models/profile.dart'; Both of these import statements will be used to call the users friends list
// import '../models/friend.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This does not look like a lot, but this took me a long time to figure out (For Dr. Layman)
    return Scaffold(
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            // item count will change to the length of the list that is storing the friends of the user
            return MySquare();
          }),
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
      child: Text(
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
      child: Text(
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

// Getting an exception saying the render box was not layed out?
class FriendsList extends StatelessWidget {
  // Used to display a list of people that are friends with the user

  const FriendsList({
    // was a const before
    super.key,
    required this.friendsList,
  });

  final List<String>
      friendsList; // This is temporary, change the type of the list to Friend

  @override
  Widget build(BuildContext context) {
    // used to display the actual list
    return Scaffold(
        body: Container(
            child: ListView.builder(
                itemCount: friendsList
                    .length, // Change this to a call to the length of the list of the users friends list friendsList.length
                itemBuilder: (context, index) {
                  return Card();
                })));
  }
}

class MySquare extends StatelessWidget {
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
