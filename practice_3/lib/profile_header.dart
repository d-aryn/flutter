//level 2
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.university,
  });

  final String name;
  final String university;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/me.jpg',
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 12),
        Text(name, style: const TextStyle(fontFamily: 'MyFont', fontSize: 26)),
        Text(university, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
