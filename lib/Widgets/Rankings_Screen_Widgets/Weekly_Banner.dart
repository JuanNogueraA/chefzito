import 'package:flutter/material.dart';

class WeeklyBanner extends StatelessWidget {
  const WeeklyBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8A65), Color(0xFFFF5252)], 
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.red.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.local_fire_department, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text("Esta Semana", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCol("2.4k", "Recetas\ncreadas"),
              _buildStatCol("15k", "Platos\ncocinados"),
              _buildStatCol("38k", "Likes dados"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCol(String number, String text) {
    return Column(
      children: [
        Text(number, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        Text(text, textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12)),
      ],
    );
  }
}