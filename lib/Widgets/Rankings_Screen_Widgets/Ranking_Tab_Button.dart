import 'package:flutter/material.dart';

class RankingTabButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const RankingTabButton({
    Key? key, required this.title, required this.icon, required this.isActive, required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? Colors.yellow[700]!.withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 14, color: isActive ? Colors.black87 : Colors.grey),
                const SizedBox(width: 4),
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: isActive ? Colors.black87 : Colors.grey)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}