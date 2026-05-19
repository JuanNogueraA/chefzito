import 'package:flutter/material.dart';
import 'package:chefzito/core/application/use_cases/settings_use_cases.dart';
import 'package:chefzito/core/infrastructure/supabase/supabase_chefzito_adapter.dart';

// Nuestras importaciones modulares
import 'package:chefzito/Widgets/Settings_Screen_Widgets/Notificaciones_Card.dart';
import 'package:chefzito/Widgets/Settings_Screen_Widgets/Privacidad_Card.dart';
import 'package:chefzito/Widgets/Settings_Screen_Widgets/Settings_Menu_Cards.dart';
import 'package:chefzito/Widgets/NavBar.dart';
import 'package:chefzito/Screens/Settings/Preferences/Theme_Appearance_Screen.dart';
import 'package:chefzito/Screens/Settings/Preferences/Language_Preferences_Screen.dart';
import 'package:chefzito/Screens/Settings/Preferences/Measurement_Units_Screen.dart';
import 'package:chefzito/Screens/Settings/Information/About_Chefzito_Screen.dart';
import 'package:chefzito/Screens/Settings/Information/Terms_Conditions_Screen.dart';
import 'package:chefzito/Screens/Settings/Information/Privacy_Policy_Screen.dart';
import 'package:chefzito/Screens/Settings/ayudaSoporte/Help_Center_Screen.dart';
import 'package:chefzito/Screens/Settings/ayudaSoporte/Report_Problem_Screen.dart';
import 'package:chefzito/Screens/Settings/ayudaSoporte/Contact_Screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SupabaseChefzitoAdapter _adapter = SupabaseChefzitoAdapter();
  late final SettingsUseCases _useCases;
  late final Future<void> _loadFuture;

  @override
  void initState() {
    super.initState();
    _useCases = SettingsUseCases(
      initPort: _adapter,
      chefNamePort: _adapter,
      authPort: _adapter,
    );
    _loadFuture = _useCases.init();
  }

  String _displayChefName() {
    final raw = _useCases.chefName.trim();
    if (raw.isEmpty) {
      return 'Invitado';
    }
    return raw[0].toUpperCase() + raw.substring(1);
  }

  void _openThemeAppearance() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ThemeAppearanceScreen()),
    );
  }

  void _openLanguagePreferences() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LanguagePreferencesScreen()),
    );
  }

  void _openMeasurementUnits() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MeasurementUnitsScreen()),
    );
  }

  void _openAboutChefzito() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AboutChefzitoScreen()),
    );
  }

  void _openTermsConditions() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TermsConditionsScreen()),
    );
  }

  void _openPrivacyPolicy() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
    );
  }

  void _openHelpCenter() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const HelpCenterScreen()),
    );
  }

  void _openReportProblem() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ReportProblemScreen()),
    );
  }

  void _openContact() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ContactScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: FutureBuilder<void>(
        future: _loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final chefName = _displayChefName();

          return Column(
            children: [
              // HEADER MORADO OSCURO
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 15,
                  left: 15,
                  right: 20,
                  bottom: 25,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2C0066), Color(0xFF4B0082)],
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
                          onTap: () => Navigator.pop(context),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          "Atrás",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Configuración",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Chef $chefName, personaliza tu experiencia",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // CUERPO MODULAR
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    const NotificacionesCard(),
                    const SizedBox(height: 20),
                    const PrivacidadCard(),
                    const SizedBox(height: 20),
                    const CuentaCard(),
                    const SizedBox(height: 20),
                    PreferenciasCard(
                      onThemeTap: _openThemeAppearance,
                      onLanguageTap: _openLanguagePreferences,
                      onUnitsTap: _openMeasurementUnits,
                    ),
                    const SizedBox(height: 20),
                    AyudaCard(
                      onHelpCenterTap: _openHelpCenter,
                      onReportProblemTap: _openReportProblem,
                      onContactTap: _openContact,
                    ),
                    const SizedBox(height: 20),
                    InformacionCard(
                      onAboutTap: _openAboutChefzito,
                      onTermsTap: _openTermsConditions,
                      onPrivacyTap: _openPrivacyPolicy,
                    ),
                    const SizedBox(height: 30),

                    // Botón Cerrar Sesión
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: OutlinedButton(
                        onPressed: () async {
                          await _useCases.logout();
                          if (!mounted) return;
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                            (route) => false,
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Colors.redAccent,
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.logout, color: Colors.redAccent),
                            SizedBox(width: 10),
                            Text(
                              "Cerrar Sesión",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Footer
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "Chefzito v1.0.0",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Hecho con ",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                ),
                              ),
                              const Icon(
                                Icons.favorite,
                                color: Colors.grey,
                                size: 12,
                              ),
                              Text(
                                " para cocineros",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}
