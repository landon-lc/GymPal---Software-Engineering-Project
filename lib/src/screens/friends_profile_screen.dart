import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FriendsProfileScreen extends StatefulWidget {
  final Map<dynamic, dynamic> user;

  const FriendsProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  _FriendsProfileScreenState createState() => _FriendsProfileScreenState();
}

class _FriendsProfileScreenState extends State<FriendsProfileScreen> {
  bool isFriendAdded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(widget.user['username']),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileImage(user: widget.user),
              SizedBox(height: 20),
              Text('Bio: ${widget.user['bio']}'),
              Text('Email: ${widget.user['email']}'),
              Text('Favorite Gym: ${widget.user['favGym']}'),
              SizedBox(height: 20),
              Visibility(
                visible: true,
                child: ElevatedButton(
                  onPressed: () {
                    _addFriend();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                  child: Text('Add Friend'),
                ),
              ),
              Visibility(
                visible: true,
                child: ElevatedButton(
                  onPressed: () {
                    _removeFriend();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Change to a contrasting color
                  ),
                  child: Text('Remove Friend'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addFriend() async {
    final currentUserID = FirebaseAuth.instance.currentUser!.uid;
    DatabaseReference _dbRef = FirebaseDatabase.instance.ref('users');
    DatabaseReference currentUserRef = _dbRef.child(currentUserID);

    try {
      // Wait for the result of once() using await
      DatabaseEvent event = await currentUserRef.child('friends').once();
      DataSnapshot snapshot = event.snapshot;

      // Check if the friend's ID already exists in the friend list
      bool isFriendAlreadyAdded = false;
      if (snapshot.value != null) {
        Map<dynamic, dynamic>? friends = snapshot.value as Map<dynamic, dynamic>?; // Cast snapshot.value
        if (friends != null) {
          friends.forEach((key, value) {
            if (value == widget.user['UID']) {
              isFriendAlreadyAdded = true;
            }
          });
        }
      }

      if (!isFriendAlreadyAdded) {
        // Add friend's ID to current user's friends list
        await currentUserRef.child('friends').push().set(widget.user['UID']);
        // Add current user's ID to the friend's friend list
        DatabaseReference friendRef = _dbRef.child(widget.user['UID']);
        await friendRef.child('friends').push().set(currentUserID);
        setState(() {
          isFriendAdded = true; // Update the state to hide the button
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Friend added successfully!'),
          ),
        );
      } else {
        setState(() {
          isFriendAdded = true; // Update the state to hide the button
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Friend already added!'),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }

  void _removeFriend() async {
    final currentUserID = FirebaseAuth.instance.currentUser!.uid;
    DatabaseReference _dbRef = FirebaseDatabase.instance.ref('users');
    DatabaseReference currentUserRef = _dbRef.child(currentUserID);

    try {
      // Listen for changes using once() instead of await
      late DataSnapshot snapshot; // Declare snapshot as late
      await currentUserRef.child('friends').once().then((event) {
        snapshot = event.snapshot; // Assign snapshot inside then callback
      });
      
      // Check if the friend's ID exists in the friend list
      if (snapshot.value != null) {
        Map<dynamic, dynamic>? friends = snapshot.value as Map<dynamic, dynamic>?; // Cast snapshot.value
        if (friends != null) {
          String? friendKey;
          friends.forEach((key, value) {
            if (value == widget.user['UID']) {
              friendKey = key;
            }
          });
          if (friendKey != null) {
            // Remove friend's ID from current user's friends list
            await currentUserRef.child('friends').child(friendKey!).remove();
            // Remove current user's ID from the friend's friend list
            DatabaseReference friendRef = _dbRef.child(widget.user['UID']).child('friends');
            // Listen for changes using orderByValue().equalTo().onValue()
            await friendRef.orderByValue().equalTo(currentUserID).onValue.first.then((event) {
              if (event.snapshot.value != null) {
                Map<dynamic, dynamic>? friendFriends = event.snapshot.value as Map<dynamic, dynamic>?; // Cast snapshot.value
                if (friendFriends != null) {
                  friendFriends.forEach((key, value) {
                    friendRef.child(key).remove();
                  });
                }
              }
            });
            setState(() {
              isFriendAdded = false; // Update the state to show the button
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Friend removed successfully!'),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Friend not found in the list!'),
              ),
            );
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You have no friends in the list!'),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }
}

class ProfileImage extends StatefulWidget {
  const ProfileImage({Key? key, required this.user}) : super(key: key);

  final Map<dynamic, dynamic> user;

  @override
  State<ProfileImage> createState() => _ProfileImage();
}

class _ProfileImage extends State<ProfileImage> {
  String? finalImageURL;

  @override
  void initState() {
    super.initState();
    finalImageSetter();
  }

  Future<String> fetchImage() async {
    // ignore: unnecessary_null_comparison
    if (widget.user != null) {
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = await storageRef
          .child('UserImages/${widget.user['image']}/userProfilePhoto.jpg')
          .getDownloadURL();
      return imageRef;
    }
    return 'no image';
  }

  Future<void> finalImageSetter() async {
    String theURL = await fetchImage();
    setState(() {
      finalImageURL = theURL;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      alignment: null,
      child: Scaffold(
        body: Center(
          child: finalImageURL != null
              ? CircleAvatar(
                  radius: 80,
                  foregroundImage: NetworkImage(finalImageURL ?? 'null'),
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
