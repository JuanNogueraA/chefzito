import 'package:flutter/material.dart';

import 'package:chefzito/Widgets/Settings_Screen_Widgets/bottom_nav_bar.dart';
import 'package:chefzito/Widgets/Settings_Screen_Widgets/custom_app_bar.dart';
import 'package:chefzito/Widgets/Settings_Screen_Widgets/gradient_button.dart';
import 'package:chefzito/Widgets/Settings_Screen_Widgets/account_data_action_tile.dart';
import 'package:chefzito/Widgets/Settings_Screen_Widgets/account_data_compact_stat.dart';
import 'package:chefzito/Widgets/Settings_Screen_Widgets/account_data_info_row.dart';
import 'package:chefzito/Widgets/Settings_Screen_Widgets/account_data_section_card.dart';
import 'package:chefzito/Widgets/Settings_Screen_Widgets/account_data_section_title.dart';
import 'package:chefzito/Screens/Settings/Account/change_password_screen.dart';

class AccountDataScreen extends StatelessWidget {
  const AccountDataScreen({super.key});

  static const Color _backgroundColor = Color(0xFFF5F7FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomGradientAppBar(
              title: 'Cuenta y Datos',
              subtitle: 'Gestiona tu información personal',
              gradientColors: const [Color(0xFF2196F3), Color(0xFF00BCD4)],
              onBack: () => Navigator.pop(context),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
              child: Column(
                children: [
                  AccountDataSectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AccountDataSectionTitle(title: 'Información de la Cuenta'),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Container(
                              width: 58,
                              height: 58,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF2196F3), Color(0xFF00BCD4)],
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Icon(Icons.person, color: Colors.white, size: 30),
                            ),
                            const SizedBox(width: 14),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'chef@cetouille.com',
                                    style: TextStyle(
                                      color: Color(0xFF1F1F1F),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '@chefviajero',
                                    style: TextStyle(
                                      color: Color(0xFF8E8E93),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        const AccountDataInfoRow(label: 'Teléfono', value: '+34 612 345 678'),
                        const SizedBox(height: 14),
                        Row(
                          children: const [
                            Expanded(
                              child: AccountDataInfoRow(label: 'Miembro desde', value: '15 Ene, 2024'),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: AccountDataInfoRow(label: 'Ubicación', value: 'Madrid, España'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFE040FB), Color(0xFFFF4081)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Estadísticas de tu Cuenta',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: const [
                            Expanded(
                              child: AccountDataCompactStat(
                                title: 'Recetas',
                                value: '42',
                                icon: Icons.restaurant_menu,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: AccountDataCompactStat(
                                title: 'Seguidores',
                                value: '1234',
                                icon: Icons.people_alt,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: AccountDataCompactStat(
                                title: 'Datos',
                                value: '127 MB',
                                icon: Icons.storage,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  AccountDataSectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AccountDataSectionTitle(title: 'Seguridad'),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F7FA),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Autenticación de dos factores',
                                      style: TextStyle(
                                        color: Color(0xFF1F1F1F),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Protege tu cuenta con un paso extra.',
                                      style: TextStyle(
                                        color: Color(0xFF8E8E93),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(value: true, onChanged: (value) {}),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        GradientButton(
                          text: 'Cambiar Contraseña',
                          colors: const [Color(0xFF7B61FF), Color(0xFFE040FB)],
                          icon: Icons.lock_reset,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ChangePasswordScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  AccountDataSectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AccountDataSectionTitle(title: 'Gestión de Datos'),
                        const SizedBox(height: 16),
                        AccountDataActionTile(
                          icon: Icons.download_rounded,
                          title: 'Descargar mis datos',
                          backgroundColor: const Color(0xFFEAF4FF),
                          iconColor: const Color(0xFF2196F3),
                          onTap: () {},
                        ),
                        const SizedBox(height: 12),
                        AccountDataActionTile(
                          icon: Icons.privacy_tip_outlined,
                          title: 'Protección de datos',
                          backgroundColor: const Color(0xFFFFF8DF),
                          iconColor: const Color(0xFFFFA000),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  AccountDataSectionCard(
                    borderColor: const Color(0xFFFF5252),
                    backgroundColor: const Color(0xFFFFF3F3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AccountDataSectionTitle(title: 'Zona Peligrosa'),
                        const SizedBox(height: 10),
                        const Text(
                          'Eliminar tu cuenta borrará tu perfil y datos asociados de forma permanente.',
                          style: TextStyle(
                            color: Color(0xFF8E8E93),
                            fontSize: 13,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 16),
                        GradientButton(
                          text: 'Eliminar Cuenta',
                          colors: const [Color(0xFFFF5252), Color(0xFFFF1744)],
                          icon: Icons.delete_forever,
                          onPressed: () {},
                        ),
                      ],
                    ),
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