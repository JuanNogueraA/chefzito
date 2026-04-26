import 'package:flutter/material.dart';

class CustomGradientAppBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Color> gradientColors;
  final VoidCallback onBack;
  final Widget? trailing;

  const CustomGradientAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    required this.gradientColors,
    required this.onBack,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: mediaQuery.padding.top + 14,
        left: 20,
        right: 20,
        bottom: 22,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onBack,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.16),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Atrás',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              ?trailing,
            ],
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 14,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
