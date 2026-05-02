import 'package:flutter/material.dart';

class AchievementsCard extends StatelessWidget {
  const AchievementsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.emoji_events, color: Colors.deepOrange),
              SizedBox(width: 8),
              Text("Logros del Mes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87)),
            ],
          ),
          const SizedBox(height: 20),
          _buildAchievementItem("🥇", "5 recetas publicadas", true),
          const SizedBox(height: 15),
          _buildAchievementItem("💬", "50 comentarios recibidos", true),
          const SizedBox(height: 15),
          _buildAchievementItem("🔥", "Racha de 7 días cocinando", false),
        ],
      ),
    );
  }

  Widget _buildAchievementItem(String emoji, String text, bool isCompleted) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: const TextStyle(color: Colors.black87, fontSize: 13))),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: isCompleted ? Colors.green : Colors.amber, borderRadius: BorderRadius.circular(10)),
          child: Text(isCompleted ? "Completado" : "En progreso", style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}