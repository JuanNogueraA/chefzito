import 'package:flutter/material.dart';

class ProfileTabButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const ProfileTabButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
            boxShadow: isActive ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)] : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: isActive ? Colors.black87 : Colors.grey),
              const SizedBox(width: 8),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isActive ? Colors.black87 : Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}