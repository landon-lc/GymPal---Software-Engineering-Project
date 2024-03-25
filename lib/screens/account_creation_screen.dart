import 'package:flutter/material.dart';

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
                    ]))));
  }
}
