import 'dart:async';
import 'friends_profile_screen.dart';
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

  Map<String, Map<dynamic, dynamic>> friendsUserData = {};

  List<String> friendsIds = [];
  Map<String, String> friendsData = {};
  StreamSubscription? friendsSubscription;

  final TextEditingController _searchController = TextEditingController();

  final List<Map<dynamic, dynamic>> _searchResults = [];

  @override
  void initState() {
    super.initState();
    loadFriends();
  }

  @override
  void dispose() {
    friendsSubscription
        ?.cancel(); // Removes database handle when screen not in use.
    super.dispose();
  }

  void loadFriends() {
    final currentUserID = FirebaseAuth.instance.currentUser!.uid;
    _dbRef.child(currentUserID).child('friends').onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      setState(() {
        friends = data.values.cast<String>().toList();
        // Fetch and store user data for each friend
        for (String friendID in friends) {
          _dbRef.child(friendID).once().then((DatabaseEvent event) {
            DataSnapshot snapshot = event.snapshot;
            setState(() {
              friendsUserData[friendID] = snapshot.value as Map<dynamic, dynamic>;
            });
          }).catchError((error) {
            print("Error loading friend's data: $error");
          });
        }
      });
    });
  }

  void _performSearch(String query) {
    _dbRef
        .orderByChild('username')
        .startAt(query)
        .endAt('$query\uf8ff')
        .once()
        .then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      setState(() {
        _searchResults.clear();
        if (snapshot.value != null) {
          Map<dynamic, dynamic>? values =
              snapshot.value as Map<dynamic, dynamic>?; // Explicit cast
          if (values != null) {
            values.forEach((key, value) {
              _searchResults.add(value);
            });
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: _performSearch,
          decoration: const InputDecoration(
            hintText: 'Search for users...',
          ),
        ),
      ),
      body: Column(children: [
        Expanded(
            child: ListView.builder(
          itemCount: _searchResults.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigate to the friends profile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FriendsProfileScreen(user: _searchResults[index])),
                );
              },
              child: ListTile(
                title: Text(_searchResults[index]['username']),
              ),
            );
          },
        )),
        Container(
            height: 25,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: const Text(
              'Your Current Friends',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: friends.length,
              itemBuilder: (context, index) {
                // Get user data for the friend
                Map<dynamic, dynamic>? userData = friendsUserData[friends[index]];
                if (userData != null) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FriendsProfileScreen(
                            user: userData,
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(userData['username']),
                    ),
                  );
                } else {
                  // You may want to show a loading indicator here
                  return Container();
                }
              },
            ),
          ),
      ]),
    );
  }
}
