import 'package:flutter/material.dart';

class AccountDataSectionTitle extends StatelessWidget {
  final String title;

  const AccountDataSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF1F1F1F),
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
