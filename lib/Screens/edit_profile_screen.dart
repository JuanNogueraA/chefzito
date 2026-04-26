import 'package:flutter/material.dart';

import '../Widgets/Settings_Screen_Widgets/bottom_nav_bar.dart';
import '../Widgets/Settings_Screen_Widgets/custom_app_bar.dart';
import '../Widgets/Settings_Screen_Widgets/custom_text_field.dart';
import '../Widgets/Settings_Screen_Widgets/gradient_button.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  static const Color _backgroundColor = Color(0xFFF5F7FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomGradientAppBar(
              title: 'Editar Perfil',
              subtitle: 'Actualiza tu información',
              gradientColors: const [Color(0xFF4A90E2), Color(0xFF7B61FF)],
              onBack: () => Navigator.pop(context),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
              child: Column(
                children: [
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
                        Stack(
                          children: [
                            Container(
                              width: 112,
                              height: 112,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF4A90E2), Color(0xFF7B61FF)],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF7B61FF).withOpacity(0.22),
                                    blurRadius: 18,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: const CircleAvatar(
                                radius: 52,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.person, size: 58, color: Color(0xFF7B61FF)),
                              ),
                            ),
                            Positioned(
                              right: 4,
                              bottom: 4,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4A90E2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'Toca para cambiar foto',
                          style: TextStyle(
                            color: Color(0xFF8E8E93),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
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
                    child: const Column(
                      children: [
                        CustomTextField(
                          label: 'Nombre',
                          hint: 'Chef Viajero',
                        ),
                        SizedBox(height: 14),
                        CustomTextField(
                          label: 'Nombre de usuario',
                          hint: '@chefviajero',
                        ),
                        SizedBox(height: 14),
                        CustomTextField(
                          label: 'Email',
                          hint: 'chef@cetouille.com',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 14),
                        CustomTextField(
                          label: 'Biografía',
                          hint: 'Cuéntales algo sobre ti',
                          maxLines: 4,
                          maxLength: 150,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GradientButton(
                    text: 'Guardar Cambios',
                    colors: const [Color(0xFF4A90E2), Color(0xFF7B61FF)],
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
