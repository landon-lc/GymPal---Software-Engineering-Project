import 'package:flutter/material.dart';
import 'profile_editor_screen.dart';

// Code that handles all widgets used and displayed in the profile screen. Add additional sections here.  
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});
    
    @override
    Widget build(BuildContext context) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Currently all using placeholder values. will need databse implementation later on. 
                ProfileImage(profileImage: 'images/Background 2.jpg'),
                ProfileUsername(profileUsername: 'PickleRick1776'),
                ProfileEditorButton(),
                ProfileAboutMe(profileAboutMeText: 'This is a bunch of placeholder text that the user would insert with their life story or personal information or warnings about run-on sentences and the like. Anyways, please feel free to poke around the app here.'),
                ProfileFavoriteGym(favoriteGym: 'Planet Fitness - Market Street')
              ]
            )
          )
        )
      );
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
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child:
        CircleAvatar(
          radius: 80,
          backgroundImage: AssetImage(profileImage),
        )
      );
  }
}

// Code for the profile editor button.
class ProfileEditorButton extends StatelessWidget {
  const ProfileEditorButton({
    super.key,
  });

  @override 
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileEditorScreen())
            );
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.blue,
        ),
        child: const Text(
          'Editor',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )
        ),
      )
    );
  }
}

// Code for displaying the users username. 
class ProfileUsername extends StatelessWidget {
  const ProfileUsername({
    super.key,
    required this.profileUsername,
  });

  final String profileUsername;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        profileUsername,
        softWrap: true,
        textDirection: TextDirection.ltr,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Colors.blue,
        )
      ),
    );
  }
}

// The AboutMe header and the text within is handled here. 
class ProfileAboutMe extends StatelessWidget {
  const ProfileAboutMe({
    super.key, 
    required this.profileAboutMeText
  });

  final String profileAboutMeText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'About Me',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )
          ),
          Text(
            profileAboutMeText,
            textDirection: TextDirection.ltr,
            softWrap: true,
          )
        ],)
      );
  }
}

// The My Gym header and the users favorite(d) gym is handled here. 
class ProfileFavoriteGym extends StatelessWidget {
  const ProfileFavoriteGym({
    super.key, 
    required this.favoriteGym
  });

  final String favoriteGym;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'My Gym',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )
          ),
          Text(
            favoriteGym,
            textDirection: TextDirection.ltr,
            softWrap: true,
          )
        ],)
      );
  }
}

