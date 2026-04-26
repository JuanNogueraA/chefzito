import 'package:flutter/material.dart';
import '../services/chefzito_service.dart';

// Nuestras importaciones modulares
import '../Widgets/Settings_Screen_Widgets/Notificaciones_Card.dart';
import '../Widgets/Settings_Screen_Widgets/Privacidad_Card.dart';
import '../Widgets/Settings_Screen_Widgets/Settings_Menu_Cards.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ChefzitoService _service = ChefzitoService();
  late final Future<void> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = _service.init();
  }

  String _displayChefName() {
    final raw = _service.currentChefName.trim();
    if (raw.isEmpty) {
      return 'Invitado';
    }
    return raw[0].toUpperCase() + raw.substring(1);
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
                  left: 15, right: 20, bottom: 25
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF2C0066), Color(0xFF4B0082)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(onTap: () => Navigator.pop(context), child: const Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.arrow_back, color: Colors.white, size: 22))),
                        const SizedBox(width: 5),
                        const Text("Atrás", style: TextStyle(color: Colors.white, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Padding(padding: EdgeInsets.only(left: 10), child: Text("Configuración", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold))),
                    const SizedBox(height: 5),
                    Padding(padding: const EdgeInsets.only(left: 10), child: Text("Chef $chefName, personaliza tu experiencia", style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14))),
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
                    const PreferenciasCard(),
                    const SizedBox(height: 20),
                    const AyudaCard(),
                    const SizedBox(height: 20),
                    const InformacionCard(),
                    const SizedBox(height: 30),
                    
                    // Botón Cerrar Sesión
                    SizedBox(
                      width: double.infinity, height: 55,
                      child: OutlinedButton(
                        onPressed: () {
                          _service.logout();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                            (route) => false,
                          );
                        },
                        style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.redAccent, width: 1.5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.logout, color: Colors.redAccent), SizedBox(width: 10), Text("Cerrar Sesión", style: TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold))]),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Footer
                    Center(
                      child: Column(
                        children: [
                          Text("Chefzito v1.0.0", style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Hecho con ", style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                              const Icon(Icons.favorite, color: Colors.grey, size: 12),
                              Text(" para cocineros", style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                            ],
                          )
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
    );
  }
}