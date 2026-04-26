import 'package:flutter/material.dart';
import '../Widgets/NavBar.dart';
import 'Settings_Screen.dart'; // Importamos la pantalla de ajustes
import '../services/chefzito_service.dart';

// ¡Nuestros componentes importados!
import '../Widgets/Profile_Screen_Widgets/Profile_Card.dart';
import '../Widgets/Profile_Screen_Widgets/Profile_Tab_Button.dart';
import '../Widgets/Profile_Screen_Widgets/Photo_Grid.dart';
import '../Widgets/Profile_Screen_Widgets/Achievements_Card.dart';
import '../Widgets/Profile_Screen_Widgets/Edit_Profile_Modal.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isMyRecipesTab = true;
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
    final displayName = _displayChefName();
    final handle = '@${displayName.toLowerCase().replaceAll(' ', '')}';

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: FutureBuilder<void>(
        future: _loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                // SECCIÓN 1: HEADER Y TARJETA
                SizedBox(
                  height: 480,
                  child: Stack(
                    children: [
                      Container(
                        height: 220,
                        width: double.infinity,
                        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20, left: 20, right: 20),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [Color(0xFF8A2BE2), Color(0xFFB026FF)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(child: Text("¡Un buen cocinero,\nSiempre esta Actualizado!", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, height: 1.2))),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                                child: const Icon(Icons.settings, color: Colors.white, size: 20),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 130, left: 20, right: 20,
                        child: ProfileCard(
                          onEditProfile: () => showEditProfileModal(context),
                          userName: displayName,
                          userHandle: handle,
                        ),
                      ),
                    ],
                  ),
                ),

                // SECCIÓN 2: TABS
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      ProfileTabButton(
                        title: "Mis Recetas", icon: Icons.grid_on, isActive: isMyRecipesTab,
                        onTap: () => setState(() => isMyRecipesTab = true),
                      ),
                      const SizedBox(width: 15),
                      ProfileTabButton(
                        title: "Guardadas", icon: Icons.favorite_border, isActive: !isMyRecipesTab,
                        onTap: () => setState(() => isMyRecipesTab = false),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // SECCIÓN 3: GRILLA Y LOGROS
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: PhotoGrid(),
                ),
                const SizedBox(height: 20),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: AchievementsCard(),
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Navbar(), 
    );
  }
}