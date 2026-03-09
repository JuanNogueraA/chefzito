import 'package:flutter/material.dart';

class SectionContainer extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final List<Widget> children;

  const SectionContainer({
    Key? key, required this.icon, required this.iconColor, required this.title, required this.children
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: iconColor.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: 15),
                Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}