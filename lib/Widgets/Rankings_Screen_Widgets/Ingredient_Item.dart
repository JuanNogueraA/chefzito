import 'package:flutter/material.dart';
import 'Trend_Tag.dart';

class IngredientItem extends StatelessWidget {
  final int rank;
  final String name;
  final String subtitle;
  final String trend;

  const IngredientItem({
    Key? key, required this.rank, required this.name, required this.subtitle, required this.trend
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5)]),
      child: Row(
        children: [
          SizedBox(width: 30, child: Center(child: Text(rank.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[400])))),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          TrendTag(trend: trend),
        ],
      ),
    );
  }
}