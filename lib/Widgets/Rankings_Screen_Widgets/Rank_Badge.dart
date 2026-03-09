import 'package:flutter/material.dart';

class RankBadge extends StatelessWidget {
  final int rank;
  const RankBadge({Key? key, required this.rank}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (rank == 1) return const Icon(Icons.workspace_premium, color: Colors.amber, size: 30);
    if (rank == 2) return const Icon(Icons.workspace_premium, color: Colors.grey, size: 30);
    if (rank == 3) return const Icon(Icons.workspace_premium, color: Colors.brown, size: 30);
    return Text(rank.toString(), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.grey));
  }
}