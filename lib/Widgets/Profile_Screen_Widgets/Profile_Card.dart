import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final VoidCallback onEditProfile;
  final String userName;
  final String userHandle;
  final String avatarUrl;
  final String bio;
  final int recipesCount;
  final int followersCount;
  final int followingCount;
  final int likesCount;

  const ProfileCard({
    Key? key,
    required this.onEditProfile,
    required this.userName,
    required this.userHandle,
    required this.avatarUrl,
    this.bio = '',
    this.recipesCount = 0,
    this.followersCount = 0,
    this.followingCount = 0,
    this.likesCount = 0,
  }) : super(key: key);

  ImageProvider _avatarProvider() {
    if (avatarUrl.isEmpty) {
      return const AssetImage('assets/img/avatar1.png');
    }
    if (avatarUrl.startsWith('http')) {
      return NetworkImage(avatarUrl);
    }
    return AssetImage(avatarUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: _avatarProvider(),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      userHandle,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: onEditProfile,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF5E00), Color(0xFFFF2A55)],
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text(
                          "Editar Perfil",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            bio.isEmpty
                ? "🍳 Cocinero aficionado | 🌍 Explorando sabores del mundo | ✨ Compartiendo recetas fáciles"
                : bio,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                "Madrid, España",
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: Color(0xFFEEEEEE), thickness: 1),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(recipesCount.toString(), "Recetas"),
              _buildStatItem(followersCount.toString(), "Seguidores"),
              _buildStatItem(followingCount.toString(), "Siguiendo"),
              _buildStatItem(likesCount.toString(), "Likes"),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBadge("🏆 Top Chef", Colors.amber),
              _buildBadge("🔥 En Racha", Colors.deepOrange),
              _buildBadge("⭐ Innovador", Colors.purpleAccent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: 11),
        ),
      ],
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }
}