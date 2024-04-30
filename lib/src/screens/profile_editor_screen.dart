import 'package:flutter/material.dart';
import 'package:test_drive/src/screens/login_screen.dart';
import 'profile_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

enum ImageSourceType { gallery, camera }

class ProfileEditorScreen extends StatefulWidget {
  const ProfileEditorScreen({super.key});

  @override
  State<ProfileEditorScreen> createState() => _ProfileEditorScreen();
}

class _ProfileEditorScreen extends State<ProfileEditorScreen> {
  final userBioController = TextEditingController();

  // IMAGE HANDLING - Opens users' native mobile device gallery.
  File userImage = File('images/ProfilePlaceholder.jpeg');
  final _picker = ImagePicker();
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        userImage = File(pickedImage.path);
      });
    }
  }

  @override
  void dispose() {
    userBioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
            padding: const EdgeInsets.all(1),
            child: Column(
              children: [
                // Opens image picker so user can select an image.
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 40),
                  child: ElevatedButton(
                    // Color and styling for the button.
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xfffffff4),
                      foregroundColor: const Color(0xff3ea9a9),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      // Getting Image
                      await _openImagePicker();
                      // Storing image to Firebase Storage.
                      final Reference storageRef =
                          FirebaseStorage.instance.ref();
                      User? currentUser = FirebaseAuth.instance.currentUser;
                      if (currentUser != null) {
                        String currentUID = currentUser.uid;
                        Reference usersImage = storageRef.child(
                            'UserImages/$currentUID/userProfilePhoto.jpg');
                        await usersImage.putFile(userImage);
                      }
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const UserProfileScreen()),
                            // Ensures a one-way route - user cannot return to account creation or login screen (without logging out).
                            (Route<dynamic> route) => false);
                      }
                    },
                    child: const Text('Upload Image'),
                  ),
                ),
                // Bio text editing field.
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xff2f2f2f),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    border:
                        Border.all(color: const Color(0xfffffff4), width: 4.0),
                  ),
                  child: TextField(
                    style: const TextStyle(color: Color(0xfffffff4)),
                    maxLines: 5,
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: 'Type a new about me...'),
                    controller: userBioController,
                  ),
                ),

                // Save button, takes user back to profile.
                TextButton(
                  // Color and styling for the button.
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff3ea9a9),
                    foregroundColor: const Color(0xfffffff4),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    User? currentUser = FirebaseAuth.instance.currentUser;
                    if (currentUser != null) {
                      String currentUID = currentUser.uid;
                      final ref =
                          FirebaseDatabase.instance.ref('users/$currentUID');
                      await ref.update({
                        'bio': userBioController.text,
                      });
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const UserProfileScreen()),
                            // Ensures a one-way route - user cannot return to account creation or login screen (without logging out).
                            (Route<dynamic> route) => false);
                      }
                    }
                  },
                  child: const Text('Save About Me'),
                ),
                // Logout button, logs user out of app.
                Container(
                    margin: const EdgeInsets.only(top: 60),
                    child: TextButton(
                      // Color and styling for the button.
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xff5E0000),
                        foregroundColor: const Color(0xfffffff4),
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                              // Ensures a one-way route - user cannot return.
                              (Route<dynamic> route) => false);
                        }
                      },
                      child: const Text('Logout'),
                    )),
              ],
            )));
  }
}
