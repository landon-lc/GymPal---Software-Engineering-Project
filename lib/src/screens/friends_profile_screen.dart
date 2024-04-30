import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FriendsProfileScreen extends StatefulWidget {
  final Map<dynamic, dynamic> user;

  const FriendsProfileScreen({super.key, required this.user});

  @override
  // ignore: library_private_types_in_public_api
  _FriendsProfileScreenState createState() => _FriendsProfileScreenState();
}

class _FriendsProfileScreenState extends State<FriendsProfileScreen> {
  bool isFriendAdded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2f2f2f),
      appBar: AppBar(
        backgroundColor: const Color(0xff3ea9a9),
        title: Text(widget.user['username'],
            style: const TextStyle(color: Color(0xfffffff4))),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileImage(user: widget.user),
              const SizedBox(height: 20),
              Text('Bio: ${widget.user['bio']}',
                  style: const TextStyle(color: Color(0xfffffff4))),
              Text('Email: ${widget.user['email']}',
                  style: const TextStyle(color: Color(0xfffffff4))),
              Text('Favorite Gym: ${widget.user['favGym']}',
                  style: const TextStyle(color: Color(0xfffffff4))),
              const SizedBox(height: 20),
              Visibility(
                visible: true,
                child: ElevatedButton(
                  onPressed: () {
                    _addFriend();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff3ea9a9),
                  ),
                  child: const Text('Add Friend',
                      style: TextStyle(color: Color(0xfffffff4))),
                ),
              ),
              Visibility(
                visible: true,
                child: ElevatedButton(
                  onPressed: () {
                    _removeFriend();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Remove Friend',
                      style: TextStyle(color: Color(0xfffffff4))),
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
    DatabaseReference dbRef = FirebaseDatabase.instance.ref('users');
    DatabaseReference currentUserRef = dbRef.child(currentUserID);

    try {
      DatabaseEvent event = await currentUserRef.child('friends').once();
      DataSnapshot snapshot = event.snapshot;

      bool isFriendAlreadyAdded = false;
      if (snapshot.value != null) {
        Map<dynamic, dynamic>? friends =
            snapshot.value as Map<dynamic, dynamic>?; // Cast snapshot.value
        if (friends != null) {
          friends.forEach((key, value) {
            if (value == widget.user['UID']) {
              isFriendAlreadyAdded = true;
            }
          });
        }
      }

      if (!isFriendAlreadyAdded) {
        await currentUserRef.child('friends').push().set(widget.user['UID']);
        DatabaseReference friendRef = dbRef.child(widget.user['UID']);
        await friendRef.child('friends').push().set(currentUserID);
        setState(() {
          isFriendAdded = true;
        });
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Friend added successfully!'),
          ),
        );
      } else {
        setState(() {
          isFriendAdded = true;
        });
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Friend already added!'),
          ),
        );
      }
    } catch (error) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }

  void _removeFriend() async {
    final currentUserID = FirebaseAuth.instance.currentUser!.uid;
    DatabaseReference dbRef = FirebaseDatabase.instance.ref('users');
    DatabaseReference currentUserRef = dbRef.child(currentUserID);

    try {
      late DataSnapshot snapshot;
      await currentUserRef.child('friends').once().then((event) {
        snapshot = event.snapshot;
      });

      if (snapshot.value != null) {
        Map<dynamic, dynamic>? friends =
            snapshot.value as Map<dynamic, dynamic>?; // Cast snapshot.value
        if (friends != null) {
          String? friendKey;
          friends.forEach((key, value) {
            if (value == widget.user['UID']) {
              friendKey = key;
            }
          });
          if (friendKey != null) {
            await currentUserRef.child('friends').child(friendKey!).remove();
            DatabaseReference friendRef =
                dbRef.child(widget.user['UID']).child('friends');
            await friendRef
                .orderByValue()
                .equalTo(currentUserID)
                .onValue
                .first
                .then((event) {
              if (event.snapshot.value != null) {
                Map<dynamic, dynamic>? friendFriends = event.snapshot.value
                    as Map<dynamic, dynamic>?; // Cast snapshot.value
                if (friendFriends != null) {
                  friendFriends.forEach((key, value) {
                    friendRef.child(key).remove();
                  });
                }
              }
            });
            setState(() {
              isFriendAdded = false;
            });
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Friend removed successfully!'),
              ),
            );
          } else {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Friend not found in the list!'),
              ),
            );
          }
        }
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You have no friends in the list!'),
          ),
        );
      }
    } catch (error) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }
}

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key, required this.user});

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
        backgroundColor: const Color(0xff2f2f2f),
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
