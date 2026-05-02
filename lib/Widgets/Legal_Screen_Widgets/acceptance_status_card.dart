import 'package:flutter/material.dart';

class AcceptanceStatusCard extends StatelessWidget {
  const AcceptanceStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: const Color(0xFF1E293B),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        );
    final bodyStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: const Color(0xFF64748B),
          fontSize: 14,
        );

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 8),
      padding: const EdgeInsets.all(20),
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
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF22C55E), size: 48),
          const SizedBox(height: 10),
          Text(
            'Has aceptado estos términos',
            textAlign: TextAlign.center,
            style: titleStyle,
          ),
          const SizedBox(height: 6),
          Text(
            'Continuando con el uso de Chefzito',
            textAlign: TextAlign.center,
            style: bodyStyle,
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          const SizedBox(height: 12),
          Text('Última aceptación: 8 de Marzo, 2026', style: bodyStyle?.copyWith(fontSize: 12)),
          const SizedBox(height: 4),
          Text('Versión: 1.0.0', style: bodyStyle?.copyWith(fontSize: 12)),
        ],
      ),
    );
  }
}
