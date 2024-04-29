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
    // Implementation of adding friend
  }

  void _removeFriend() async {
    // Implementation of removing friend
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

  // Fetching Image from Firebase Storage
  Future<String> fetchImage() async {
    // Getting the current user.
    // Ensuring user exists.
    if (widget.user != null) {
      // With the users UID, we can now access that user within the database.
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
