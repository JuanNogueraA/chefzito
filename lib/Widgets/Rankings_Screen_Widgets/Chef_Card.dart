import 'package:flutter/material.dart';
import 'Rank_Badge.dart';

class ChefCard extends StatelessWidget {
  final int rank;
  final String name;
  final String handle;
  final String subtitle;
  final String score;
  final String imgUrl;

  const ChefCard({
    Key? key, required this.rank, required this.name, required this.handle, 
    required this.subtitle, required this.score, required this.imgUrl
  }) : super(key: key);

  ImageProvider _avatarProvider() {
    if (imgUrl.isEmpty) {
      return const AssetImage('assets/img/avatar1.png');
    }
    if (imgUrl.startsWith('http')) {
      return NetworkImage(imgUrl);
    }
    return AssetImage(imgUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Column(
        children: [
          RankBadge(rank: rank),
          const SizedBox(height: 10),
          CircleAvatar(radius: 40, backgroundImage: _avatarProvider()),
          const SizedBox(height: 10),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(handle, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [const Icon(Icons.menu_book, size: 12, color: Colors.grey), const SizedBox(width: 4), Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12))],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [const Icon(Icons.local_fire_department, color: Colors.deepOrange, size: 16), const SizedBox(width: 4), Text(score, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))],
          ),
        ],
      ),
    );
  }
}