import 'package:flutter/material.dart';

class AccountDataSectionCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final Color? borderColor;

  const AccountDataSectionCard({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: borderColor == null ? null : Border.all(color: borderColor!, width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}
