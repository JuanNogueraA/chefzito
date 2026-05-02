import 'package:flutter/material.dart';

class ArrowItem extends StatelessWidget {
  final String title;
  final bool isLast;
  final VoidCallback? onTap;

  const ArrowItem({Key? key, required this.title, this.isLast = false, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: isLast ? 20 : 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
            Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
          ],
        ),
      ),
    );
  }
}