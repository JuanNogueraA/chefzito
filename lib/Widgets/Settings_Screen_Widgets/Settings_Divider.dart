import 'package:flutter/material.dart';

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(color: Colors.grey[200], thickness: 1, height: 1),
    );
  }
}