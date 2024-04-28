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
      body: Center(
        child: Column(children: [
        // ignore: prefer_interpolation_to_compose_strings
        Expanded(child: Text('Bio: ' + user['bio'])),
        // ignore: prefer_interpolation_to_compose_strings
        Expanded(child: Text('Email: ' + user['email'])),
        // ignore: prefer_interpolation_to_compose_strings
        Expanded(child: Text('Favorite Gym: ' + user['favGym'])),
      ]),
      )
    );
  }
}
