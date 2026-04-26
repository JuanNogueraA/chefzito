import 'package:flutter/material.dart';

class WarningCard extends StatelessWidget {
  const WarningCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: const Color(0xFF92400E),
          fontSize: 14,
          height: 1.45,
        );

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFEF3C7)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.warning_amber_rounded,
              color: Color(0xFFF59E0B),
              size: 22,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Estos términos constituyen un acuerdo legal entre tú y Chefzito. Al continuar usando la aplicación, confirmas que has leído, comprendido y aceptado estos términos.',
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
