import 'package:flutter/material.dart';
import 'package:chefzito/Widgets/NavBar.dart';
import 'package:chefzito/Screens/Settings/Settings_Screen.dart';
import 'package:chefzito/core/application/use_cases/profile_use_cases.dart';
import 'package:chefzito/core/infrastructure/supabase/supabase_chefzito_adapter.dart';
import 'package:chefzito/models/recipe_model.dart';

// Componentes importados
import 'package:chefzito/Widgets/Profile_Screen_Widgets/Profile_Card.dart';
import 'package:chefzito/Widgets/Profile_Screen_Widgets/Profile_Tab_Button.dart';
import 'package:chefzito/Widgets/Profile_Screen_Widgets/Photo_Grid.dart';
import 'package:chefzito/Widgets/Profile_Screen_Widgets/Achievements_Card.dart';
import 'package:chefzito/Widgets/Profile_Screen_Widgets/Edit_Profile_Modal.dart'
    show showEditProfileModal;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isMyRecipesTab = true;
  final SupabaseChefzitoAdapter _adapter = SupabaseChefzitoAdapter();
  late final ProfileUseCases _useCases;
  late final Future<void> _loadFuture;

  @override
  void initState() {
    super.initState();
    _useCases = ProfileUseCases(_adapter);
    _loadFuture = _useCases.init();
  }

  String _displayChefName() {
    final raw = _useCases.chefName.trim();
    if (raw.isEmpty) {
      return 'Invitado';
    }
    return raw[0].toUpperCase() + raw.substring(1);
  }

  List<RecipeModel> _getRecipesToDisplay() {
    if (isMyRecipesTab) {
      return _adapter.getMyRecipes();
    } else {
      return _adapter.getSavedRecipes();
    }
  }

  int _getRecipesCount() {
    return _adapter.getMyRecipes().length;
  }

  int _getLikesCount() {
    // Contar likes de todas las recetas del usuario
    int total = 0;
    for (final recipe in _adapter.getMyRecipes()) {
      total += recipe.likesCount ?? 0;
    }
    return total;
  }

  int _getCommentsCount() {
    // Contar comentarios en posts del usuario
    final userId = _useCases.currentUser?.id ?? '';
    int total = 0;
    for (final comment in _adapter.getCommentsByPost('')) {
      // Este es un placeholder, deberíamos tener acceso a los posts del usuario
      total += 1;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final displayName = _displayChefName();
    final handle = '@${displayName.toLowerCase().replaceAll(' ', '')}';
    final currentUser = _useCases.currentUser;
    final avatarUrl = currentUser?.avatarUrl ?? '';

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
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top + 20,
                          left: 20,
                          right: 20,
                        ),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF8A2BE2),
                              Color(0xFFB026FF),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text(
                                "¡Un buen cocinero,\nSiempre esta Actualizado!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  height: 1.2,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SettingsScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 130,
                        left: 20,
                        right: 20,
                        child: ProfileCard(
                          onEditProfile: () => showEditProfileModal(
                            context,
                            useCases: _useCases,
                            user: currentUser,
                            onUpdated: () {
                              if (mounted) {
                                setState(() {});
                              }
                            },
                          ),
                          userName: displayName,
                          userHandle: handle,
                          avatarUrl: avatarUrl,
                          bio: currentUser?.bio ?? '',
                          recipesCount: _getRecipesCount(),
                          followersCount: currentUser?.followersCount ?? 0,
                          followingCount: currentUser?.followingCount ?? 0,
                          likesCount: _getLikesCount(),
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
                        title: "Mis Recetas",
                        icon: Icons.grid_on,
                        isActive: isMyRecipesTab,
                        onTap: () => setState(() => isMyRecipesTab = true),
                      ),
                      const SizedBox(width: 15),
                      ProfileTabButton(
                        title: "Guardadas",
                        icon: Icons.favorite_border,
                        isActive: !isMyRecipesTab,
                        onTap: () => setState(() => isMyRecipesTab = false),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // SECCIÓN 3: GRILLA DE RECETAS
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PhotoGrid(
                    recipes: _getRecipesToDisplay(),
                  ),
                ),
                const SizedBox(height: 20),

                // SECCIÓN 4: LOGROS
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AchievementsCard(
                    recipesCount: _getRecipesCount(),
                    commentsCount: _getCommentsCount(),
                    followersCount: currentUser?.followersCount ?? 0,
                  ),
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