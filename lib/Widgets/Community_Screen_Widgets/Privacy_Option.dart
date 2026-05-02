import 'package:flutter/material.dart';

class PrivacyOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isActive;
  final Color color;
  final VoidCallback onTap;

  const PrivacyOption({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isActive,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border.all(color: isActive ? color : Colors.grey[300]!, width: 1.5),
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Icon(icon, color: isActive ? color : Colors.grey[400], size: 30),
              const SizedBox(height: 8),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isActive ? color : Colors.grey[800])),
              Text(subtitle, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
            ],
          ),
        ),
      ),
    );
  }
}