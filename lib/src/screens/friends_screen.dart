import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FriendsListScreen extends StatefulWidget {
  const FriendsListScreen({super.key});

  @override
  FriendsListScreenState createState() => FriendsListScreenState();
}

class FriendsListScreenState extends State<FriendsListScreen> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('users');

  List<String> friends = [];

  List<String> friendIDs = [];

  StreamSubscription? _friendsSubscription;

  @override
  void initState() {
    super.initState();
    loadFriends();
  }

  @override
  void dispose() {
    _friendsSubscription
        ?.cancel(); // Removes database handle when screen not in use.
    super.dispose();
  }

  void loadFriends() {
    _friendsSubscription = _dbRef
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child('friends')
        .onValue
        .listen((event) {
      final List<String> loadFriends = [];
      final List<String> loadFriendIDs = [];
      final data = event.snapshot.value as Map<dynamic, dynamic>? ??
          {}; // Allows for NULL, instead providing empty map.
      data.forEach((key, value) {
        loadFriends.add(value.toString());
        loadFriendIDs.add(key.toString());
      });
      setState(() {
        friends = loadFriends;
        friendIDs = loadFriendIDs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = 400;
    double containerHeight = 250;
    final userSearchController = TextEditingController();

    return Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          TextField(
            decoration: const InputDecoration(
                labelText: 'Search for Friends!', border: OutlineInputBorder()),
            controller: userSearchController,
          ),
          Positioned(
              // This is going to be a users friends list
              bottom: 300,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 1,
                  color: Colors.black,
                )),
                width: containerWidth,
                height: containerHeight,
                child: ListView.builder(
                    itemCount: friends.length,
                    itemBuilder: (context, index) {
                      return FriendsMySquare(userID: friendIDs[index]);
                    }),
              )),
          // Not yet implemented

          // Positioned(
          //     // Search results (might be replaced)
          //     top: 75,
          //     child: Container(
          //         decoration: BoxDecoration(
          //             border: Border.all(
          //           width: 1,
          //           color: Colors.black,
          //         )),
          //         width: containerWidth,
          //         height: 100,
          //         child: ListView.builder(
          //             itemCount: searchResults.length,
          //             itemBuilder: (context, index) {
          //               return FriendsMySquare(
          //                   child: searchResults[
          //                       index]); // Make a different box if you want a new color
          //             }))),
          const Positioned(top: 180, child: Text('All Your Current Friends!')),
          const Positioned(
              bottom: 270, child: Text('All Incoming Friend Requests')),
          Positioned(
              // This is going to be Received Friend Requests
              bottom: 20,
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                    width: 1,
                    color: Colors.black,
                  )),
                  width: containerWidth,
                  height: containerHeight,
                  child: ListView.builder(
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return const SearchMySquare(); // temporary
                      }))),
        ]);
  }
}

class FriendsMySquare extends StatelessWidget {
  final String userID;
  const FriendsMySquare({super.key, required this.userID});

  // This is used to define the square for each section of the list
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Container(
          height: 20,
          color: Colors.grey, // color can change, just a random color I chose
          child: Text(fetchUsername(userID).toString()),
        ));
  }
}

FutureOr<String> fetchUsername(String userID) async {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();
  final snapshot = await dbRef.child('users/$userID/username').get();
  FutureOr<String> userName = snapshot.value.toString();
  return userName;
}

// Uncomment if needed; not currently referenced for use.

// class FriendsList extends StatelessWidget {
//   // Used to display a list of people that are friends with the user

//   const FriendsList({
//     // was a const before
//     super.key,
//     required this.friendsList,
//   });

//   final List<String>
//       friendsList; // This is temporary, change the type of the list to Friend

//   @override
//   Widget build(BuildContext context) {
//     // used to display the actual list
//     return Scaffold(
//         body: ListView.builder(
//             itemCount: friendsList
//                 .length, // Change this to a call to the length of the list of the users friends list friendsList.length
//             itemBuilder: (context, index) {
//               return const Card();
//             }));
//   }
// }

// class FriendImages extends StatelessWidget {
//   const FriendImages({
//     super.key,
//     required this.friendImage,
//   });

//   final String friendImage;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.all(60),
//         child: CircleAvatar(
//           radius: 40,
//           backgroundImage: AssetImage(friendImage),
//         ));
//   }
// }

// class FriendsGyms extends StatelessWidget {
//   const FriendsGyms({
//     super.key,
//     required this.friendGyms,
//   });

//   final String friendGyms;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Text(
//         friendGyms, // you'll change this to something with flutter once we store friends
//       ),
//     );
//   }
// }

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
        friendUsername,
      ),
    );
  }
}

class SearchMySquare extends StatelessWidget {
  // May have to use a stack for the name, picture, and username
  const SearchMySquare({super.key});

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
