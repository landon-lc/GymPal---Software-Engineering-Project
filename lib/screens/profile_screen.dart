import 'package:flutter/material.dart';
import 'profile_editor_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
              body: SingleChildScrollView(
                  child: Column(children: [
                    // Database Implementation
                    // Currently all using placeholder values. will need databse implementation later on.
                    ProfileImage(profileImage: 'images/Background 2.jpg'),
                    ProfileUsername(),
                    ProfileEditorButton(),
                    ProfileAboutMe(
                        profileAboutMeText:
                            'This is a bunch of placeholder text that the user would insert with their life story or personal information or warnings about run-on sentences and the like. Anyways, please feel free to poke around the app here.'),
                    ProfileFavoriteGym(favoriteGym: 'Planet Fitness - Market Street')
          ]))));
    }
}


// Code for displaying the users profile picture.
class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.profileImage,
  });

  final String profileImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 60),
        child: CircleAvatar(
          radius: 80,
          backgroundImage: AssetImage(profileImage),
        ));
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
        child: Text( text.data ?? 'USERNAME_NOT_FOUND',
          softWrap: true,
          textDirection: TextDirection.ltr,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.blue,
          )),
        );
      }
    );
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
  const ProfileAboutMe({super.key, required this.profileAboutMeText});

  final String profileAboutMeText;

  @override
  Widget build(BuildContext context) {
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
              profileAboutMeText,
              textDirection: TextDirection.ltr,
              softWrap: true,
            )
          ],
        ));
  }
}

// The My Gym header and the users favorite(d) gym is handled here.
class ProfileFavoriteGym extends StatelessWidget {
  const ProfileFavoriteGym({super.key, required this.favoriteGym});

  final String favoriteGym;

  @override
  Widget build(BuildContext context) {
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
              favoriteGym,
              textDirection: TextDirection.ltr,
              softWrap: true,
            )
          ],
        ));
  }
}
