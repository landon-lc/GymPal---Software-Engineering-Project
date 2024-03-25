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
                          await Future.delayed(const Duration(seconds: 3));
                          // NOTE - No protections against a current account being overwritten. Will need to be accounted for later. 
                          // Creates the user within the Realtime Database. 
                          DatabaseReference ref = FirebaseDatabase.instance.ref('users/${newUsernameController.text}');
                          await ref.set({
                            'username': newUsernameController.text,
                            'password': newPasswordController.text,
                            'email': newEmailController.text,
                          });
                          // Registers the user within Firebase Authentication. 
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: newEmailController.text, 
                            password: newPasswordController.text);
                          // Continues to the users' profile screen.
                          if (context.mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PageNavigation()));
                          }
                        },
                        child: const Text('Create Account'),
                      ),
                    ]))));
  }
}
