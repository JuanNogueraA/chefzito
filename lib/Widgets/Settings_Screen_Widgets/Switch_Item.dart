import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SwitchItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isLast;

  const SwitchItem({
    Key? key, required this.title, required this.subtitle, required this.value, required this.onChanged, this.isLast = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: isLast ? 20 : 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
                const SizedBox(height: 2),
                Text(subtitle, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
              ],
            ),
          ),
          CupertinoSwitch(value: value, onChanged: onChanged, activeColor: Colors.green),
        ],
      ),
    );
  }
}