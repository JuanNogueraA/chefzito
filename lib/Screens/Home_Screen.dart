import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../Screens/Community_Screen.dart';
import '../Screens/Rankings_Screen.dart';
import '../Screens/Search_Screen.dart';
import '../Widgets/NavBar.dart';
import '../services/chefzito_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ChefzitoService _service = ChefzitoService();
  late final Future<void> _loadFuture;
  bool _showContent = false;

  @override
  void initState() {
    super.initState();
    _loadFuture = _service.init();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _showContent = true;
        });
      }
    });
  }

  void _navigateSmooth(Widget screen) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 360),
        reverseTransitionDuration: const Duration(milliseconds: 280),
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final slide = Tween<Offset>(
            begin: const Offset(0.06, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(position: slide, child: child),
          );
        },
      ),
    );
  }

  int _likesForRecipe(int recipeId) {
    final relatedPosts = _service
        .getPosts()
        .where((post) => post.recipeId == recipeId)
        .toList();

    if (relatedPosts.isEmpty) {
      return 0;
    }

    return relatedPosts.fold(0, (sum, post) => sum + post.likesCount);
  }

  List<RecipeModel> _topRecipes() {
    final recipes = List<RecipeModel>.from(_service.getRecipes());
    recipes.sort((a, b) => _likesForRecipe(b.id).compareTo(_likesForRecipe(a.id)));
    return recipes.take(3).toList();
  }

  Color _recipeTint(int index) {
    const palette = [
      Color(0xFFFFF3E8),
      Color(0xFFEFF7FF),
      Color(0xFFF3EDFF),
    ];
    return palette[index % palette.length];
  }

  Color _recipeAccent(int index) {
    const accents = [
      Color(0xFFFF7A1A),
      Color(0xFF1E88E5),
      Color(0xFF8E24AA),
    ];
    return accents[index % accents.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<void>(
        future: _loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final topRecipes = _topRecipes();
          final trends = _service.getTrends();

          return Column(
            children: [
              AnimatedSlide(
                duration: const Duration(milliseconds: 420),
                offset: _showContent ? Offset.zero : const Offset(0, -0.08),
                curve: Curves.easeOutCubic,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 420),
                  opacity: _showContent ? 1 : 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF5722),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      top: 56,
                      left: 24,
                      right: 24,
                      bottom: 84,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '¡Hola Chef! 👋',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 33,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                '¿Qué preparamos\npara hoy?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const _RobotChefIcon(),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Transform.translate(
                  offset: const Offset(0, -40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ActionCard(
                        icon: Icons.search_rounded,
                        label: 'Buscar\nrecetas',
                        color: const Color(0xFFFF5722),
                        onTap: () => _navigateSmooth(const SearchScreen()),
                      ),
                      _ActionCard(
                        icon: Icons.add_circle_outline_rounded,
                        label: 'Crear receta',
                        color: const Color(0xFF4CAF50),
                        onTap: () => _navigateSmooth(const CommunityScreen()),
                      ),
                      _ActionCard(
                        icon: Icons.trending_up_rounded,
                        label: 'Tendencias',
                        color: const Color(0xFF9C27B0),
                        onTap: () => _navigateSmooth(const RankingsScreen()),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.local_fire_department,
                                  color: Colors.orange,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Trending Ahora',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () => Navigator.pushReplacementNamed(
                                context,
                                '/rankings',
                              ),
                              child: const Text(
                                'Ver todo',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (topRecipes.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Center(
                            child: Text('No hay recetas disponibles en este momento.'),
                          ),
                        )
                      else
                        ...topRecipes.asMap().entries.map((entry) {
                          final index = entry.key;
                          final recipe = entry.value;
                          return _RecipeCard(
                            recipe: recipe,
                            likes: _likesForRecipe(recipe.id),
                            index: index,
                            tint: _recipeTint(index),
                            accent: _recipeAccent(index),
                          );
                        }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: trends
                              .map(
                                (trend) => Chip(
                                  label: Text('${trend.hashtag} (${trend.count})'),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.purple, Colors.pink],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.lightbulb, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text(
                                    'Tip del día',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Tienes ${_service.getRecipes().length} recetas cargadas desde JSON. Usa Buscar para encontrar la ideal según tus ingredientes.',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
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

class _RecipeCard extends StatelessWidget {
  final RecipeModel recipe;
  final int likes;
  final int index;
  final Color tint;
  final Color accent;

  const _RecipeCard({
    required this.recipe,
    required this.likes,
    required this.index,
    required this.tint,
    required this.accent,
  });

  String _emojiForTitle() {
    final title = recipe.title.toLowerCase();
    if (title.contains('pasta')) return '🍝';
    if (title.contains('ensalada')) return '🥗';
    if (title.contains('taco')) return '🌮';
    if (title.contains('pollo')) return '🍗';
    return '🍽️';
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 420 + (index * 110)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 26),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            color: tint,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white),
            boxShadow: const [
              BoxShadow(
                color: Color(0x15000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accent.withValues(alpha: 0.14),
                  ),
                  alignment: Alignment.center,
                  child: Text(_emojiForTitle(), style: const TextStyle(fontSize: 32)),
                ),
                const SizedBox(height: 10),
                Text(
                  recipe.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 28 / 1.55, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 6),
                Text(
                  recipe.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.access_time, size: 16, color: accent),
                    const SizedBox(width: 4),
                    Text('${recipe.prepTimeMin} min'),
                    const SizedBox(width: 12),
                    const Text('•'),
                    const SizedBox(width: 12),
                    Text(recipe.difficulty),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.favorite, color: Colors.red, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      '$likes',
                      style: TextStyle(
                        color: accent,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Ícono del robot con gorro de chef ─────────────────────────────────
class _RobotChefIcon extends StatelessWidget {
  const _RobotChefIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Image.asset(
          'assets/img/Chefcito_CompletoGorroBlanco.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

// ── Tarjeta de acción individual ──────────────────────────────────────
class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
        width: 102,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE8E8E8)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.28),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
