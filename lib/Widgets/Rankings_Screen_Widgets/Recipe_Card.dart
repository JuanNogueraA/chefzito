import 'package:flutter/material.dart';
import 'Rank_Badge.dart';
import 'Trend_Tag.dart';

class RecipeCard extends StatelessWidget {
  final int rank;
  final String title;
  final int postsCount;
  final int likes;
  final String trend;
  final String imgUrl;

  const RecipeCard({
    Key? key,
    required this.rank,
    required this.title,
    required this.postsCount,
    required this.likes,
    required this.trend,
    required this.imgUrl,
  }) : super(key: key);

  ImageProvider _imageProvider() {
    if (imgUrl.isEmpty) {
      return const AssetImage('assets/img/Chefcito_corona.png');
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
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              image: _imageProvider(),
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.menu_book, size: 12, color: Colors.grey),
              const SizedBox(width: 4),
              Text('Posts $postsCount', style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(width: 10),
              const Icon(Icons.favorite, size: 12, color: Colors.grey),
              const SizedBox(width: 4),
              Text('$likes', style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 10),
          TrendTag(trend: trend),
        ],
      ),
    );
  }
}