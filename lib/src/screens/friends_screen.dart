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

  StreamSubscription? _friendsSubscription;

  TextEditingController _searchController = TextEditingController();

  List<Map<dynamic, dynamic>> _searchResults = [];

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
      final data = event.snapshot.value as Map<dynamic, dynamic>? ??
          {}; // Allows for NULL, instead providing empty map.
      data.forEach((key, value) {
        loadFriends.add(value.toString());
      });
      setState(() {
        friends = loadFriends;
      });
    });
  }

  void _performSearch(String query) {
  _dbRef.orderByChild('username')
    .startAt(query)
    .endAt(query + "\uf8ff")
    .once()
    .then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      setState(() {
        _searchResults.clear();
        if (snapshot.value != null) {
          Map<dynamic, dynamic>? values = snapshot.value as Map<dynamic, dynamic>?; // Explicit cast
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
          decoration: InputDecoration(
            hintText: 'Search for users...',
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to the friends profile screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FriendsProfileScreen(user: _searchResults[index])),
              );
            },
            child: ListTile(
              title: Text(_searchResults[index]['username']),
            ),
          );
        },
      ),
    );
  }

  void removeFriend(int index) {
    // TODO

    // String friendIdToRemove = friends[index];
    // _dbRef.child(FirebaseAuth.instance.currentUser!.uid)
    //     .child('friends')
    //     .child(friendIdToRemove)
    //     .remove()
    //     .then((_) {
    //   setState(() {
    //     friends.removeAt(index);
    //   });
    // });
  }
}
