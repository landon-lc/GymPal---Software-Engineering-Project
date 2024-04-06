import 'package:flutter/material.dart';
import 'profile_screen.dart';

class ProfileEditorScreen extends StatefulWidget {
  const ProfileEditorScreen ({super.key});

  @override 
  State<ProfileEditorScreen> createState() => _ProfileEditorScreen();
}

class _ProfileEditorScreen extends State<ProfileEditorScreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [
              // Implement sub-screens.
              ProfileEditorScreenFeatures(),
              ProfileEditorBackButton(),
            ])
          )
        )
    );
  }
}


// // Handler for the profile editing screen.
// class ProfileEditorScreen extends StatelessWidget {
//   const ProfileEditorScreen({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return const Padding(
//         padding: EdgeInsets.only(top: 40),
//         child: Column(children: [
//           ProfileEditorScreenFeatures(),
//           ProfileEditorBackButton()
//         ]));
//   }
// }

// Placeholder for future profile editor screen features.
class ProfileEditorScreenFeatures extends StatelessWidget {
  const ProfileEditorScreenFeatures({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "This page ain't done yet.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ));
  }
}

// Code for the profile editor back button.
class ProfileEditorBackButton extends StatelessWidget {
  const ProfileEditorBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserProfileScreen()));
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text('TAKE ME BACK RIGHT THIS INSTANT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ));
  }
}
