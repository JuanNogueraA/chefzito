import 'package:flutter/material.dart';

class AchievementsCard extends StatelessWidget {
  final int recipesCount;
  final int commentsCount;
  final int followersCount;

  const AchievementsCard({
    Key? key,
    this.recipesCount = 0,
    this.commentsCount = 0,
    this.followersCount = 0,
  }) : super(key: key);

  bool _isRecipesCompleted() => recipesCount >= 5;
  bool _isCommentsCompleted() => commentsCount >= 50;
  bool _isStreakCompleted() => followersCount >= 7;

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
              Text(
                "Logros del Mes",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildAchievementItem(
            "🥇",
            "$recipesCount recetas publicadas",
            _isRecipesCompleted(),
          ),
          const SizedBox(height: 15),
          _buildAchievementItem(
            "💬",
            "$commentsCount comentarios recibidos",
            _isCommentsCompleted(),
          ),
          const SizedBox(height: 15),
          _buildAchievementItem(
            "🔥",
            "Racha de $followersCount días cocinando",
            _isStreakCompleted(),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementItem(
    String emoji,
    String text,
    bool isCompleted,
  ) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.black87, fontSize: 13),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isCompleted ? Colors.green : Colors.amber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            isCompleted ? "Completado" : "En progreso",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}