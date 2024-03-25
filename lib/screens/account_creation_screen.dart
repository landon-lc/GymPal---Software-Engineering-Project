import 'package:flutter/material.dart';

// The user is creating an account for the first time. 
class AccountCreationScreen extends StatelessWidget {
  const AccountCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: SingleChildScrollView(
                child: Column(children: [
                   Text('placeholder')
        ]))));
  }
}