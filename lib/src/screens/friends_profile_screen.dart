import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './profile_editor_screen.dart';
import 'package:firebase_database/firebase_database.dart';

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
        child: Text(user['bio']),
      ),
    );
  }
}
