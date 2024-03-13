import 'package:flutter/material.dart';

class UserName extends StatelessWidget {
  const UserName({
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