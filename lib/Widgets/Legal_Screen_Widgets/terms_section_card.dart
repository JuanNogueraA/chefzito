import 'package:flutter/material.dart';

class TermsSectionCard extends StatelessWidget {
  final String title;
  final String description;

  const TermsSectionCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: const Color(0xFF1E293B),
          fontWeight: FontWeight.w700,
          fontSize: 16,
        );
    final bodyStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: const Color(0xFF64748B),
          fontSize: 14,
          height: 1.5,
        );

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFF6FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 18,
                  color: Color(0xFF3B82F6),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(title, style: titleStyle),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(description, style: bodyStyle),
        ],
      ),
    );
  }
}
