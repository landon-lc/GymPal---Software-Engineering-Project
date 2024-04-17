import 'page_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

// The user is creating an account for the first time.
class AccountCreationScreen extends StatefulWidget {
  const AccountCreationScreen({super.key});

  @override
  State<AccountCreationScreen> createState() => _AccountCreationScreen();
}

class _AccountCreationScreen extends State<AccountCreationScreen> {
  final newUsernameController = TextEditingController();
  final newPasswordController = TextEditingController();
  final newEmailController = TextEditingController();

  @override
  void dispose() {
    newUsernameController.dispose();
    newPasswordController.dispose();
    newEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Account Creation'),
        ),
        body: Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        decoration: const InputDecoration(
                            labelText: 'Create a Username'),
                        controller: newUsernameController,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                            labelText: 'Create a Password'),
                        // MAY SET TO TRUE LATER - DO NOT DELETE
                        obscureText: false,
                        controller: newPasswordController,
                      ),
                      TextField(
                        decoration: const InputDecoration(
                            labelText: 'Enter your Email'),
                        controller: newEmailController,
                      ),
                      // CREATING THE USERS ACCOUNT
                      // For a detailed explanation of this section, see Issue #65.
                      ElevatedButton(
                        onPressed: () async {
                          // The user account is created in Auth. If the email is already in use the account will not be created. (See Email Enumeration, Issue #65)
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: newEmailController.text,
                                  password: newPasswordController.text);
                          // The user will now be logged in.
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: newEmailController.text,
                            password: newPasswordController.text,
                          );
                          // The current users unique identifier (UID) will now be fetched.
                          User? currentUser = FirebaseAuth.instance.currentUser;
                          if (currentUser != null) {
                            String currentUID = currentUser.uid;
                            // Creates the user within the Realtime Database using their UID.
                            DatabaseReference ref = FirebaseDatabase.instance
                                .ref('users/$currentUID');
                            await ref.set({
                              'UID': currentUID,
                              'username': newUsernameController.text,
                              'password': newPasswordController.text,
                              'email': newEmailController.text,
                              'bio': 'No bio yet!',
                              'image': 'No link.',
                              'favGym': 'No gym yet!',
                            });
                            final Reference storageRef = FirebaseStorage.instance.ref();
                            Reference usersImage = storageRef.child('UserImages/$currentUID/userProfilePhoto.jpg');
                            await usersImage.putFile(File('images/ProfilePlaceholder.jpeg'));
                          }
                          // Continues to the users' profile screen. They are logged in and ready to begin using the app.
                          if (context.mounted) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PageNavigation()),
                                // Ensures a one-way route - user cannot return to account creation or login screen (without logging out).
                                (Route<dynamic> route) => false);
                          }
                        },
                        child: const Text('Create Account'),
                      ),
                    ]))));
  }
}
