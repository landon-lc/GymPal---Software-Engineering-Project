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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends List'),
      ),
      body: friends.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: friends.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(friends[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => removeFriend(index),
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
