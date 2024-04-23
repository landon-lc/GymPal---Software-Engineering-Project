import 'package:flutter/material.dart';

class FriendsProfileScreen extends StatelessWidget {
  final Map<dynamic, dynamic> user;

  const FriendsProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user['username']),
      ),
      body: Column(children: [
        Expanded(child: Text('Bio: ' + user['bio'])),
        Expanded(child: Text('Email: ' + user['email'])),
        Expanded(child: Text('Favorite Gym: ' + user['favGym'])),
      ]),
    );
  }
}
