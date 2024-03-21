import 'package:flutter/material.dart';

// Code that handles all widgets used in the profile screen. 
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});
    
    @override
    Widget build(BuildContext context) {
      // Insert all needed widgets
      //ProfileImage(profileImage: 'source'),
      return const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                ProfileImage(profileImage: 'images/Background 2.jpg'),
                ProfileUsername(profileUsername: 'Bob the PlaceHolder Username')
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
    return Image.asset(
      profileImage, 
      height: 200.0, 
      width: 200.0,
      fit: BoxFit.cover,
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
      ),
    );
  }
}