import 'package:flutter/material.dart';

import 'package:chefzito/models/recipe_model.dart';
import 'package:chefzito/Screens/Search/Recipe_Detail_Screen.dart';

class SearchResultsScreen extends StatelessWidget {
  final List<String> selectedIngredients;
  final List<RecipeModel> recipes;

  const SearchResultsScreen({
    super.key,
    required this.selectedIngredients,
    required this.recipes,
  });

  int _matchPercent(RecipeModel recipe) {
    if (selectedIngredients.isEmpty) {
      return 0;
    }

    final source =
        '${recipe.title} ${recipe.description} ${recipe.steps.join(' ')}'.toLowerCase();

    final matches = selectedIngredients
        .where((ingredient) => source.contains(ingredient.toLowerCase()))
        .length;

    final percent = ((matches / selectedIngredients.length) * 100).round();
    return percent.clamp(40, 99);
  }

  String _emojiForRecipe(RecipeModel recipe) {
    final title = recipe.title.toLowerCase();
    if (title.contains('pasta')) return '🍝';
    if (title.contains('ensalada')) return '🥗';
    if (title.contains('taco')) return '🌮';
    if (title.contains('pollo')) return '🍗';
    return '🍽️';
  }

  ImageProvider? _coverProvider(RecipeModel recipe) {
    final cover = recipe.coverImageUrl.trim();
    if (cover.isEmpty) {
      return null;
    }
    if (cover.startsWith('http')) {
      return NetworkImage(cover);
    }
    return AssetImage(cover);
  }

  void _openDetail(BuildContext context, RecipeModel recipe) {
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 340),
        reverseTransitionDuration: const Duration(milliseconds: 260),
        pageBuilder: (context, animation, secondaryAnimation) {
          return RecipeDetailScreen(
            recipe: recipe,
            selectedIngredients: selectedIngredients,
          );
        },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F7),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF12B886), Color(0xFF0CA678)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                      SizedBox(width: 4),
                      Text(
                        'Atrás',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Recetas para ti',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${recipes.length} recetas encontradas',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          Expanded(
            child: recipes.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'No encontramos recetas con esos ingredientes.\nPrueba agregando más opciones.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(14, 14, 14, 20),
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      final percent = _matchPercent(recipe);

                      return TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration: Duration(milliseconds: 340 + (index * 90)),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, (1 - value) * 16),
                              child: child,
                            ),
                          );
                        },
                        child: GestureDetector(
                          onTap: () => _openDetail(context, recipe),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x12000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 138,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(16),
                                        ),
                                        gradient: const LinearGradient(
                                          colors: [Color(0xFFFFE8CC), Color(0xFFFFF4E6)],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        image: _coverProvider(recipe) == null
                                            ? null
                                            : DecorationImage(
                                                image: _coverProvider(recipe)!,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      alignment: Alignment.center,
                                      child: _coverProvider(recipe) == null
                                          ? Text(
                                              _emojiForRecipe(recipe),
                                              style: const TextStyle(fontSize: 62),
                                            )
                                          : null,
                                    ),
                                    Positioned(
                                      right: 10,
                                      top: 10,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF22C55E),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          '$percent% Match',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        recipe.title,
                                        style: const TextStyle(
                                          fontSize: 23 / 1.3,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xFF111827),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Icons.schedule, size: 14),
                                          const SizedBox(width: 4),
                                          Text('${recipe.prepTimeMin} min'),
                                          const SizedBox(width: 10),
                                          const Text('•'),
                                          const SizedBox(width: 10),
                                          Text(recipe.difficulty),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Wrap(
                                        spacing: 6,
                                        runSpacing: 6,
                                        children: selectedIngredients
                                            .take(3)
                                            .map(
                                              (ingredient) => Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFFDCFCE7),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  ingredient,
                                                  style: const TextStyle(
                                                    color: Color(0xFF15803D),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
