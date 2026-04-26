import 'package:flutter/material.dart';

import '../Widgets/Settings_Screen_Widgets/bottom_nav_bar.dart';
import '../Widgets/Settings_Screen_Widgets/custom_app_bar.dart';
import '../Widgets/Settings_Screen_Widgets/custom_text_field.dart';
import '../Widgets/Settings_Screen_Widgets/gradient_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomGradientAppBar(
              title: 'Cambiar Contraseña',
              subtitle: 'Protege tu cuenta',
              gradientColors: const [Color(0xFF7B61FF), Color(0xFFE040FB)],
              onBack: () => Navigator.pop(context),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F4FF),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFBFD3FF)),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.shield_outlined, color: Color(0xFF4A90E2), size: 26),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mantén tu cuenta segura',
                                style: TextStyle(
                                  color: Color(0xFF1F1F1F),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Usa una contraseña fuerte y única para proteger tu acceso.',
                                style: TextStyle(
                                  color: Color(0xFF8E8E93),
                                  fontSize: 13,
                                  height: 1.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        CustomTextField(
                          label: 'Contraseña Actual',
                          hint: 'Ingresa tu contraseña actual',
                          obscureText: !_showCurrent,
                          suffixIcon: Icon(
                            _showCurrent ? Icons.visibility_off : Icons.visibility,
                            color: const Color(0xFF8E8E93),
                          ),
                          onSuffixTap: () => setState(() => _showCurrent = !_showCurrent),
                        ),
                        const SizedBox(height: 14),
                        CustomTextField(
                          label: 'Nueva Contraseña',
                          hint: 'Crea una nueva contraseña',
                          obscureText: !_showNew,
                          suffixIcon: Icon(
                            _showNew ? Icons.visibility_off : Icons.visibility,
                            color: const Color(0xFF8E8E93),
                          ),
                          onSuffixTap: () => setState(() => _showNew = !_showNew),
                        ),
                        const SizedBox(height: 14),
                        CustomTextField(
                          label: 'Confirmar Nueva Contraseña',
                          hint: 'Repite la nueva contraseña',
                          obscureText: !_showConfirm,
                          suffixIcon: Icon(
                            _showConfirm ? Icons.visibility_off : Icons.visibility,
                            color: const Color(0xFF8E8E93),
                          ),
                          onSuffixTap: () => setState(() => _showConfirm = !_showConfirm),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GradientButton(
                    text: 'Cambiar Contraseña',
                    colors: const [Color(0xFF7B61FF), Color(0xFFE040FB)],
                    onPressed: () {},
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const ProfileBottomNavBar(),
    );
  }
}
