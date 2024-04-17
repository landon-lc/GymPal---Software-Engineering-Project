import 'package:flutter/material.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double containerWidth = 400; // Change this when changing the containers height and width
    double containerHeight = 250;
    final userSearchController = TextEditingController(); // Used for search bar
    List<String> _names = ['Brandon', 'Landon', 'Michael', 'Riley', 'James']; // This will be a call to data base to retrieve friends and / or all people in database

    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        TextField(
          decoration: 
          const InputDecoration(
            labelText: 'Search for Friends!',
            border: OutlineInputBorder()),
          controller: userSearchController,
        ),
        Positioned( // This is going to be a users friends list
          bottom: 300,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black,
              )
            ),
            width: containerWidth,
            height: containerHeight,
            child: ListView.builder( // This is going to be the list of friends
              itemCount: _names.length,
              itemBuilder: (context, index) {
                return friendsMySquare(child: _names[index]);
            }),
          )
        ),
        Positioned( // Search results (might be replaced)
          top: 75,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black,
              )
            ),
            width: containerWidth,
            height: 100,
            child: ListView.builder( 
              itemCount: 15,
              itemBuilder: (context, index) {
                return searchMySquare(); // Make a different box if you want a new color 
              }
            )
          )
        ),
        Positioned(top: 180,child: Text("All Your Current Friends!")),
        Positioned(bottom: 270, child: Text("All Incoming Friend Requests")),
        Positioned( // This is going to be Received Friend Requests
          bottom: 20,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.black,
              )
            ),
            width: containerWidth,
            height: containerHeight,
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return const friendsMySquare(child: 'Random');
              }
            )
          )
        ),
      ]
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
        body: ListView.builder(
            itemCount: friendsList
                .length, // Change this to a call to the length of the list of the users friends list friendsList.length
            itemBuilder: (context, index) {
              return const Card();
            }));
  }
}

class friendsMySquare extends StatelessWidget {
  final String child;
  const friendsMySquare({super.key, required this.child});

  // This is used to define the square for each section of the list
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Container(
          height: 20,
          color: Colors
              .grey, // color can change, just a random color I chose
          child: Text(child),
        ));
  }
}

class searchMySquare extends StatelessWidget { // May have to use a stack for the name, picture, and username 
  const searchMySquare({super.key});

  // This is used to define the square for each section of the list
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Container(
          height: 20,
          color: Colors.green, // color can change, just a random color I chose
        ));
  }
}

