import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './profile_editor_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Stateful Widget for the Profile Screen.
class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreen();
}

/// User Profile Screen Handler. Controls all classes that create the screen.
/// These include [ProfileImage], [ProfileUsername], [ProfileEditorButton], [ProfileAboutMe], [ProfileFavoriteGym]
class _UserProfileScreen extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xfffffff4),
                primary: const Color(0xff3ea9a9),
                brightness: Brightness.dark),
            useMaterial3: true,
            scaffoldBackgroundColor: const Color(0xff2f2f2f)),
        debugShowCheckedModeBanner: false,
        home: const Scaffold(
            appBar: null,
            body: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  // Calls to each screen.
                  ProfileImage(),
                  ProfileUsername(),
                  ProfileAboutMe(),
                  ProfileFavoriteGym(),
                  ProfileEditorButton(),
                ]))));
  }
}

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key});

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
    User? currentUser = FirebaseAuth.instance.currentUser;
    // Ensuring user exists.
    if (currentUser != null) {
      String currentUID = currentUser.uid;
      // With the users UID, we can now access that user within the database.
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = await storageRef
          .child('UserImages/$currentUID/userProfilePhoto.jpg')
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
    return Padding(
        padding: const EdgeInsets.only(top: 14),
        child: Container(
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
            ))));
  }
}

// Code for the profile editor button.
class ProfileEditorButton extends StatelessWidget {
  const ProfileEditorButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 60),
        child: TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfileEditorScreen()));
          },
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xfffffff4),
          ),
          child: const Text(
            'Edit Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff3ea9a9),
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
          ),
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
            padding: const EdgeInsets.all(2),
            child: Text(text.data ?? 'USERNAME_FETCH_FAIL',
                softWrap: true,
                textDirection: TextDirection.ltr,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xfffffff4),
                  fontSize: 20.0,
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
              padding: const EdgeInsets.only(
                  top: 36, left: 10, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 12),
                    child: const Text(
                      'About Me',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xfffffff4),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color(0xff3ea9a9),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Text(
                        bioText.data ?? 'BIO_FETCH_FAIL',
                        textDirection: TextDirection.ltr,
                        softWrap: true,
                        style: const TextStyle(
                          color: Color(0xfffffff4),
                          height: 1.0,
                        ),
                      )),
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
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 12),
                    child: const Text(
                      'My Gym',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color(0xff3ea9a9),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Text(
                        gymText.data ?? 'GYM_FETCH_FAIL',
                        textDirection: TextDirection.ltr,
                        softWrap: true,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xfffffff4),
                          height: 1.0,
                        ),
                      )),
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
