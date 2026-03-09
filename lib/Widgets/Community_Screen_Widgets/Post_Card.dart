import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String userName;
  final String userHandle;
  final String time;
  final String recipeName;
  final String likes;
  final String caption;
  final String imageUrl;
  final bool isFriend;
  final bool isPrivate;

  const PostCard({
    Key? key,
    required this.userName,
    required this.userHandle,
    required this.time,
    required this.recipeName,
    required this.likes,
    required this.caption,
    required this.imageUrl,
    required this.isFriend,
    this.isPrivate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(backgroundImage: NetworkImage('https://randomuser.me/api/portraits/lego/1.jpg'), radius: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text("$userHandle • $time", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                    ],
                  ),
                ),
                if (isFriend && !isPrivate) Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(border: Border.all(color: Colors.green), borderRadius: BorderRadius.circular(15)),
                  child: Row(children: const [Icon(Icons.person_add_alt_1, color: Colors.green, size: 14), SizedBox(width: 4), Text("Amigo", style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold))]),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.more_horiz, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: isPrivate ? Colors.blue : Colors.orange.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.menu_book, size: 16, color: isPrivate ? Colors.blue : Colors.orange),
                  const SizedBox(width: 6),
                  Text(recipeName, style: TextStyle(color: isPrivate ? Colors.blue : Colors.orange, fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
            ),
            if (isPrivate) Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(15)),
                child: Row(mainAxisSize: MainAxisSize.min, children: const [Icon(Icons.lock_outline, size: 14, color: Colors.white), SizedBox(width: 6), Text("Solo Amigos", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))]),
              ),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(imageUrl, height: 300, width: double.infinity, fit: BoxFit.cover),
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Icon(Icons.favorite_border, size: 28), SizedBox(width: 15),
                Icon(Icons.chat_bubble_outline, size: 26), Spacer(),
                Icon(Icons.bookmark_border, size: 28),
              ],
            ),
            const SizedBox(height: 10),
            Text("$likes me gusta", style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87, fontSize: 14),
                children: [TextSpan(text: "$userHandle ", style: const TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: caption)],
              ),
            ),
            const SizedBox(height: 5),
            Text("Ver los comentarios", style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          ],
        ),
      ),
    );
  }
}