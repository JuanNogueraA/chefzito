import 'package:flutter/material.dart';

class GradientWelcomeCard extends StatelessWidget {
  const GradientWelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        );
    final bodyStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.white.withOpacity(0.9),
          fontSize: 14,
          height: 1.45,
        );

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.gavel, color: Colors.white, size: 28),
          const SizedBox(height: 12),
          Text('Bienvenido a Chefzito', style: titleStyle),
          const SizedBox(height: 8),
          Text(
            'Por favor lee cuidadosamente estos términos antes de usar nuestra aplicación. Al utilizar Chefzito, aceptas estos términos en su totalidad.',
            style: bodyStyle,
          ),
        ],
      ),
    );
  }
}
