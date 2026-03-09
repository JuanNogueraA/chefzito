import 'package:flutter/material.dart';

class TrendTag extends StatelessWidget {
  final String trend;
  const TrendTag({Key? key, required this.trend}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.trending_up, color: Colors.green, size: 14),
          const SizedBox(width: 4),
          Text(trend, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }
}