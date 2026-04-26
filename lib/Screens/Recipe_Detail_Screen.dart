import 'package:flutter/material.dart';

import '../models/recipe_model.dart';

class RecipeDetailScreen extends StatelessWidget {
  final RecipeModel recipe;
  final List<String> selectedIngredients;

  const RecipeDetailScreen({
    super.key,
    required this.recipe,
    required this.selectedIngredients,
  });

  List<String> _derivedIngredients() {
    final source =
        '${recipe.title} ${recipe.description} ${recipe.steps.join(' ')}'.toLowerCase();

    const vocabulary = [
      'pollo',
      'pasta',
      'tomate',
      'cebolla',
      'ajo',
      'arroz',
      'huevos',
      'queso',
      'leche',
      'pan',
      'aceite',
      'sal',
      'res',
      'carne',
      'tortilla',
      'vegetales',
      'salsa',
      'pimiento',
      'zanahoria',
      'brocoli',
    ];

    final found = <String>[];
    for (final word in vocabulary) {
      if (source.contains(word)) {
        final pretty = word[0].toUpperCase() + word.substring(1);
        if (!found.contains(pretty)) {
          found.add(pretty);
        }
      }
    }

    for (final selected in selectedIngredients) {
      if (!found.any((item) => item.toLowerCase() == selected.toLowerCase())) {
        found.add(selected);
      }
    }

    return found.take(8).toList();
  }

  String _qtyForIndex(int index) {
    const quantities = ['450 g', '1 und', '150 g', 'Al gusto', 'A gusto', '2 cdas'];
    return quantities[index % quantities.length];
  }

  @override
  Widget build(BuildContext context) {
    final ingredients = _derivedIngredients();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 270,
              pinned: true,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFFE8CC), Color(0xFFFFF4E6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Center(
                        child: Text('🍝', style: TextStyle(fontSize: 120)),
                      ),
                    ),
                    Positioned(
                      right: 14,
                      bottom: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          recipe.generatedByAi ? 'Receta IA' : 'Receta clásica',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF374151),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      recipe.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4B5563),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.schedule, size: 16),
                        const SizedBox(width: 4),
                        Text('${recipe.prepTimeMin} min'),
                        const SizedBox(width: 10),
                        const Text('•'),
                        const SizedBox(width: 10),
                        Text(recipe.difficulty),
                      ],
                    ),
                    const SizedBox(height: 14),
                    _SectionCard(
                      title: '🧂 Ingredientes',
                      child: Column(
                        children: List.generate(ingredients.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    ingredients[index],
                                    style: const TextStyle(
                                      color: Color(0xFF1F2937),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFEDD5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    _qtyForIndex(index),
                                    style: const TextStyle(
                                      color: Color(0xFFEA580C),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _SectionCard(
                      title: '📝 Pasos a seguir',
                      child: Column(
                        children: recipe.steps.asMap().entries.map((entry) {
                          final index = entry.key;
                          final step = entry.value;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 13,
                                  backgroundColor: const Color(0xFFE5E7EB),
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(
                                      color: Color(0xFF374151),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    step,
                                    style: const TextStyle(
                                      color: Color(0xFF374151),
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _SectionCard(
                      title: '💡 Tips del Chef',
                      background: const Color(0xFFFFF7D6),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('• Prueba y ajusta sal al final para mejor sabor.'),
                          SizedBox(height: 8),
                          Text('• Cocina a fuego medio para conservar textura.'),
                          SizedBox(height: 8),
                          Text('• Sirve caliente y decora con hierbas frescas.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  final Color? background;

  const _SectionCard({
    required this.title,
    required this.child,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: background ?? Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
