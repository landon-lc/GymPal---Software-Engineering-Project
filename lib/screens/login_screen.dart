import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}


class _LoginScreen extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Login'),
		            controller: usernameController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
		            controller: passwordController,
              ),
              const SizedBox(height: 20),
              // ElevatedButton(
                // onPressed: () {
                //   try {
                //     FirebaseAuth.instance.signInWithEmailAndPassword(
                //       email: usernameController.text,
                //       password: passwordController.text,
                //     );
                //   } on FirebaseAuthException catch (e) {
                //     if (e.code == 'user-not-found') {
                //       print('No user found for that email.');
                //     } else if (e.code == 'wrong-password') {
                //       print('Wrong password provided for that user.');
                //     }
                //   }
                // },
                // child: Text('Login'),
              // ),
            ]
          )
        )
      )
    );
  }
}

