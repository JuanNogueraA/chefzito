import 'package:flutter/material.dart';
import 'package:chefzito/Widgets/NavBar.dart';
import 'package:chefzito/core/application/use_cases/rankings_use_cases.dart';
import 'package:chefzito/core/infrastructure/supabase/supabase_chefzito_adapter.dart';
import 'package:chefzito/models/post_model.dart';
import 'package:chefzito/models/recipe_model.dart';
import 'package:chefzito/models/user_model.dart';

// Nuestras piezas
import 'package:chefzito/Widgets/Rankings_Screen_Widgets/Ranking_Tab_Button.dart';
import 'package:chefzito/Widgets/Rankings_Screen_Widgets/Current_List.dart';
import 'package:chefzito/Widgets/Rankings_Screen_Widgets/Weekly_Banner.dart';

class RankingsScreen extends StatefulWidget {
  const RankingsScreen({Key? key}) : super(key: key);

  @override
  State<RankingsScreen> createState() => _RankingsScreenState();
}

class _RankingsScreenState extends State<RankingsScreen> {
  int selectedTab = 0;
  final SupabaseChefzitoAdapter _adapter = SupabaseChefzitoAdapter();
  late final RankingsUseCases _useCases;
  late final Future<void> _loadFuture;

  @override
  void initState() {
    super.initState();
    _useCases = RankingsUseCases(_adapter);
    _loadFuture = _useCases.init();
  }

  String _displayChefName() {
    final raw = _useCases.chefName.trim();
    if (raw.isEmpty) {
      return 'Invitado';
    }
    return raw[0].toUpperCase() + raw.substring(1);
  }

  int _likesForRecipe(String recipeId, List<PostModel> posts) {
    final related = posts.where((post) => post.recipeId == recipeId);
    return related.fold(0, (sum, post) => sum + post.likesCount);
  }

  int _postsForRecipe(String recipeId, List<PostModel> posts) {
    return posts.where((post) => post.recipeId == recipeId).length;
  }

  List<RecipeRankingItem> _buildRecipeRankings(
    List<RecipeModel> recipes,
    List<PostModel> posts,
  ) {
    final rankings = recipes
        .map(
          (recipe) => RecipeRankingItem(
            recipe: recipe,
            postsCount: _postsForRecipe(recipe.id, posts),
            likes: _likesForRecipe(recipe.id, posts),
          ),
        )
        .toList();

    rankings.sort((a, b) => b.likes.compareTo(a.likes));
    return rankings.take(6).toList();
  }

  List<ChefRankingItem> _buildChefRankings(
    List<UserModel> users,
    List<RecipeModel> recipes,
    List<PostModel> posts,
  ) {
    final recipesByAuthor = <String, List<RecipeModel>>{};
    for (final recipe in recipes) {
      recipesByAuthor.putIfAbsent(recipe.authorId, () => []).add(recipe);
    }

    final rankings = <ChefRankingItem>[];
    for (final user in users) {
      final userRecipes = recipesByAuthor[user.id] ?? const [];
      if (userRecipes.isEmpty) {
        continue;
      }
      var likes = 0;
      for (final recipe in userRecipes) {
        likes += _likesForRecipe(recipe.id, posts);
      }
      rankings.add(
        ChefRankingItem(
          user: user,
          recipeCount: userRecipes.length,
          likes: likes,
        ),
      );
    }

    rankings.sort((a, b) => b.likes.compareTo(a.likes));
    return rankings.take(6).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: FutureBuilder<void>(
        future: _loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final chefName = _displayChefName();
          final recipes = _useCases.getRecipes();
          final posts = _useCases.getPosts();
          final users = _useCases.getUsers();
          final recipeRankings = _buildRecipeRankings(recipes, posts);
          final chefRankings = _buildChefRankings(users, recipes, posts);
          final ingredientRankings = _useCases.getIngredientRanking(limit: 6);

          return Column(
            children: [
              // HEADER CON DEGRADADO Y TABS
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 20,
                  left: 20, right: 20, bottom: 20
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFD500F9), Color(0xFFFF4081)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.emoji_events, color: Colors.white, size: 28),
                                SizedBox(width: 8),
                                Text("Rankings", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text("Chef $chefName, lo mejor de la comunidad", style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14)),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                          child: const Icon(Icons.smart_toy, color: Colors.white, size: 40),
                        )
                      ],
                    ),
                    const SizedBox(height: 25),
                    // TABS
                    Container(
                      height: 45,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        children: [
                          RankingTabButton(title: "Recetas", icon: Icons.menu_book, isActive: selectedTab == 0, onTap: () => setState(() => selectedTab = 0)),
                          RankingTabButton(title: "Chefs", icon: Icons.workspace_premium, isActive: selectedTab == 1, onTap: () => setState(() => selectedTab = 1)),
                          RankingTabButton(title: "Ingredientes", icon: Icons.eco, isActive: selectedTab == 2, onTap: () => setState(() => selectedTab = 2)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // CUERPO DE LA LISTA Y BANNER
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  children: [
                    CurrentList(
                      selectedTab: selectedTab,
                      recipeRankings: recipeRankings,
                      chefRankings: chefRankings,
                      ingredientRankings: ingredientRankings,
                    ),
                    const SizedBox(height: 10),
                    const WeeklyBanner(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}