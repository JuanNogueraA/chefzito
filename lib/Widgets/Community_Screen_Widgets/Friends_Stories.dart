import 'package:flutter/material.dart';

class FriendsStories extends StatelessWidget {
  final Color primaryColor; // Lo pasamos como parámetro para mantener el color

  const FriendsStories({Key? key, required this.primaryColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> friends = [
      {"name": "María", "img": "https://randomuser.me/api/portraits/women/44.jpg"},
      {"name": "Carlos", "img": "https://randomuser.me/api/portraits/men/32.jpg"},
      {"name": "Ana", "img": "https://randomuser.me/api/portraits/women/68.jpg"},
      {"name": "Pedro", "img": "https://randomuser.me/api/portraits/men/45.jpg"},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: friends.map((f) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: primaryColor, width: 2)),
                  child: CircleAvatar(radius: 28, backgroundImage: NetworkImage(f["img"]!)),
                ),
                const SizedBox(height: 5),
                Text(f["name"]!, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87)),
              ],
            ),
          )).toList(),
        ),
      ),
    );
  }
}