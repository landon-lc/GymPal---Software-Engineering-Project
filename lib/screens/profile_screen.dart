import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({
    super.key,
    required this.profileUserName,
  });

  final String profileUserName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        profileUserName,
        softWrap: true,
        textDirection: TextDirection.ltr,
      ),
    );
  }
}