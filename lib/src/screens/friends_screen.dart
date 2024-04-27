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
    friendsSubscription = _dbRef
        .child('users/${FirebaseAuth.instance.currentUser!.uid}/friends')
        .onValue
        .listen((event) {
      final data = event.snapshot.value as List<dynamic>? ?? [];
      setState(() {
        friendsIds = List<String>.from(data.map((friend) => friend.toString()));
      });
      fetchFriendsData();
    });
  }

  void fetchFriendsData() async {
  for (String friendId in friendsIds) {
    try {
      DatabaseEvent event = await _dbRef.child('users/$friendId/username').once();
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        setState(() {
          friendsData[friendId] = snapshot.value.toString();
        });
      }
    } catch (error) {
      print("Error fetching friend data: $error");
    }
  }
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
          decoration:
              BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
          child: const Text(
            'Your Current Friends',
          ),
        ),
        Expanded(
            child: ListView.builder(
              itemCount: friendsData.length,
              itemBuilder: (context, index) {
                final friendId = friendsData.keys.elementAt(index);
                final friendUsername = friendsData[friendId]!;
                return GestureDetector(
                  onTap: () {
                    // Navigate to the friend's profile screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FriendsProfileScreen(
                          user: {'userId': friendId, 'username': friendUsername},
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(friendUsername),
                  ),
            );
          },
        ))
      ]),
    );
  }
}
