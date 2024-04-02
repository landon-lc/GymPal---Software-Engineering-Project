import 'page_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
                        decoration: const InputDecoration(labelText: 'Create a Username'),
                        controller: newUsernameController,
                      ),
                      TextField(
                        decoration:
                            const InputDecoration(labelText: 'Create a Password'),
                        // MAY SET TO TRUE LATER - DO NOT DELETE
                        obscureText: false,
                        controller: newPasswordController,
                      ),
                      TextField(
                        decoration: const InputDecoration(labelText: 'Enter your Email'),
                        controller: newEmailController,
                      ),
                      // CREATING THE USERS ACCOUNT
                      ElevatedButton(
                        onPressed: () async {
                          // Future delay used to make navigator button work, allows time for database integrations to go through. 
                          await Future.delayed(const Duration(seconds: 3));
                          // First, a check will be done to ensure an account using this email has not already been created. 
                          // INSERT ACCOUNT CHECK
                          // Second, the user is registered within Firebase Authentication. 
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: newEmailController.text, 
                            password: newPasswordController.text);
                          // Creates the user within the Realtime Database. 
                          DatabaseReference ref = FirebaseDatabase.instance.ref('users/${newUsernameController.text}');
                          await ref.set({
                            'username': newUsernameController.text,
                            'password': newPasswordController.text,
                            'email': newEmailController.text,
                          });
                          // INSERT AUTH LOGIN
                          // Continues to the users' profile screen.
                          if (context.mounted) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PageNavigation()),
                                // Ensures a one-way route - user cannot return to account creation or login screen (without logging out). 
                                (Route<dynamic> route) => false);
                          }
                        },
                        child: const Text('Create Account'),
                      ),
                    ]))));
  }
}
