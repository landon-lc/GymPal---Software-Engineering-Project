import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'profile_editor_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Stateful Widget for the Profile Screen.
class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreen();
}

// User Profile Screen Handler. Controls all classes that create the screen.
class _UserProfileScreen extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: null,
            body: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  // Calls to each screen.
                  ProfileImage(),
                  ProfileUsername(),
                  ProfileEditorButton(),
                  ProfileAboutMe(),
                  ProfileFavoriteGym()
                ]))));
  }
}

// Code for displaying the users profile picture.
class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
  });

  // final Image usersImage = fetchImage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchImage(),
        builder: (BuildContext context, AsyncSnapshot<Image> usersImageData) {
          if (usersImageData.hasData) {
            final finalUserImage = usersImageData.data;
            if (finalUserImage != null) {
              final ImageProvider imageAccess = finalUserImage.image;
                Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CircleAvatar(
                  minRadius: 80,
                  maxRadius: 80,
                  foregroundImage: imageAccess,
        ));
            }
          }
          return const Padding(
                padding: EdgeInsets.only(top: 10),
                child: CircleAvatar(
                  radius: 80,
                  foregroundImage: null,
              ));
            
          });
  }
}

// Image Fetcher
// This method fetches the About Me (or bio) for displaying on the profile screen.
Future<Image> fetchImage() async {
  // Getting the current user.
  User? currentUser = FirebaseAuth.instance.currentUser;
  // Ensuring user exists.
  if (currentUser != null) {
    String currentUID = currentUser.uid;
    // With the users UID, we can now access that user within the database.
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = await storageRef.child('UserImages/$currentUID/userProfilePhoto.jpg').getDownloadURL();
    final userProfilePhoto = Image.network(imageRef);
    return userProfilePhoto; 
  }
  final Image placeholderImage = Image.file(File('images/ProfilePlaceholder.jpg'));
  return placeholderImage;
}

// Code for the profile editor button.
class ProfileEditorButton extends StatelessWidget {
  const ProfileEditorButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfileEditorScreen()));
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          child: const Text('Editor',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ));
  }
}

// Code for displaying the users username.
class ProfileUsername extends StatelessWidget {
  const ProfileUsername({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchUsername(),
        builder: (BuildContext context, AsyncSnapshot<String> text) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Text(text.data ?? 'USERNAME_FETCH_FAIL',
                softWrap: true,
                textDirection: TextDirection.ltr,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue,
                )),
          );
        });
  }
}

// This method fetches the username for displaying on the profile screen.
Future<String> fetchUsername() async {
  // Getting the current user.
  User? currentUser = FirebaseAuth.instance.currentUser;
  String theUsername = '';
  // Ensuring user exists.
  if (currentUser != null) {
    String currentUID = currentUser.uid;
    // With the users UID, we can now access that user within the database.
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('users/$currentUID/username').get();
    if (snapshot.exists) {
      theUsername = snapshot.value.toString();
    }
  }
  return theUsername;
}

// The AboutMe header and the text within is handled here.
class ProfileAboutMe extends StatelessWidget {
  const ProfileAboutMe({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchBio(),
        builder: (BuildContext context, AsyncSnapshot<String> bioText) {
          return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('About Me',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    bioText.data ?? 'BIO_FETCH_FAIL',
                    textDirection: TextDirection.ltr,
                    softWrap: true,
                  )
                ],
              ));
        });
  }
}

// This method fetches the About Me (or bio) for displaying on the profile screen.
Future<String> fetchBio() async {
  // Getting the current user.
  User? currentUser = FirebaseAuth.instance.currentUser;
  String theBio = '';
  // Ensuring user exists.
  if (currentUser != null) {
    String currentUID = currentUser.uid;
    // With the users UID, we can now access that user within the database.
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('users/$currentUID/bio').get();
    if (snapshot.exists) {
      theBio = snapshot.value.toString();
    }
  }
  return theBio;
}

// The My Gym header and the users favorite(d) gym is handled here.
class ProfileFavoriteGym extends StatelessWidget {
  const ProfileFavoriteGym({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchGym(),
        builder: (BuildContext context, AsyncSnapshot<String> gymText) {
          return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('My Gym',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    gymText.data ?? 'GYM_FETCH_FAIL',
                    textDirection: TextDirection.ltr,
                    softWrap: true,
                  )
                ],
              ));
        });
  }
}

// This method fetches the users favorite gym for displaying on the profile screen.
Future<String> fetchGym() async {
  // Getting the current user.
  User? currentUser = FirebaseAuth.instance.currentUser;
  String theGym = '';
  // Ensuring user exists.
  if (currentUser != null) {
    String currentUID = currentUser.uid;
    // With the users UID, we can now access that user within the database.
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('users/$currentUID/favGym').get();
    if (snapshot.exists) {
      theGym = snapshot.value.toString();
    }
  }
  return theGym;
}
