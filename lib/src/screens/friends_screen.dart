import 'dart:async';
import 'friends_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FriendsListScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const FriendsListScreen({Key? key});

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
    friendsSubscription?.cancel();
    super.dispose();
  }

  void loadFriends() {
    final currentUserID = FirebaseAuth.instance.currentUser!.uid;
    _dbRef.child(currentUserID).child('friends').onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      setState(() {
        friends = data.values.cast<String>().toList();
        for (String friendID in friends) {
          _dbRef.child(friendID).once().then((DatabaseEvent event) {
            DataSnapshot snapshot = event.snapshot;
            setState(() {
              friendsUserData[friendID] =
                  snapshot.value as Map<dynamic, dynamic>;
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
              snapshot.value as Map<dynamic, dynamic>?;
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
      backgroundColor: const Color(0xff2f2f2f),
      appBar: AppBar(
        backgroundColor: const Color(0xff3ea9a9),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          FriendsProfileScreen(user: _searchResults[index]),
                    ),
                  );
                },
                child: Card(
                  elevation: 2,
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: ListTile(
                    title: Text(_searchResults[index]['username']),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          height: 25,
          decoration: BoxDecoration(
            color: const Color(0xff3ea9a9),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: const Center(
            child: Text(
              'Your Current Friends',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: friends.length,
            itemBuilder: (context, index) {
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
                  child: Card(
                    elevation: 2,
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: ListTile(
                      title: Text(userData['username']),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ]),
    );
  }
}
