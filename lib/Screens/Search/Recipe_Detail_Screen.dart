import 'package:flutter/material.dart';

import 'package:chefzito/models/recipe_model.dart';

class RecipeDetailScreen extends StatefulWidget {
  final RecipeModel recipe;
  final List<String> selectedIngredients;

  const RecipeDetailScreen({
    super.key,
    required this.recipe,
    required this.selectedIngredients,
  });

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  bool _pulseUp = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _pulseUp = false;
      });
    });
  }

  List<String> _derivedIngredients() {
    final source =
        '${widget.recipe.title} ${widget.recipe.description} ${widget.recipe.steps.join(' ')}'
            .toLowerCase();

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

    for (final selected in widget.selectedIngredients) {
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

  Future<void> _startCookingFlow() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const _CookingLoadingDialog(),
    );

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) {
      return;
    }

    Navigator.of(context, rootNavigator: true).pop();

    if (!mounted) {
      return;
    }

    await _showInteractiveCookingModal();
  }

  Future<void> _showInteractiveCookingModal() async {
    var currentStep = 0;
    final steps = widget.recipe.steps;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final progress = (currentStep + 1) / steps.length;

            return Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          '👨‍🍳 Vamos a cocinar',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    Text(
                      'Paso ${currentStep + 1} de ${steps.length}',
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 9,
                        backgroundColor: const Color(0xFFE5E7EB),
                        color: const Color(0xFF16A34A),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 240),
                      child: Container(
                        key: ValueKey(currentStep),
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFE5E7EB)),
                        ),
                        child: Text(
                          steps[currentStep],
                          style: const TextStyle(
                            color: Color(0xFF374151),
                            height: 1.45,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: currentStep == 0
                                ? null
                                : () {
                                    setModalState(() {
                                      currentStep -= 1;
                                    });
                                  },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              side: const BorderSide(color: Color(0xFFCBD5E1)),
                            ),
                            child: const Text('Anterior'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (currentStep < steps.length - 1) {
                                setModalState(() {
                                  currentStep += 1;
                                });
                                return;
                              }

                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(this.context).showSnackBar(
                                const SnackBar(
                                  content: Text('✅ ¡Listo! Completaste la receta.'),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF4D2D),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              currentStep < steps.length - 1 ? 'Siguiente' : 'Finalizar',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
                          widget.recipe.generatedByAi ? 'Receta IA' : 'Receta clásica',
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
                      widget.recipe.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.recipe.description,
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
                        Text('${widget.recipe.prepTimeMin} min'),
                        const SizedBox(width: 10),
                        const Text('•'),
                        const SizedBox(width: 10),
                        Text(widget.recipe.difficulty),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Center(
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(
                          begin: _pulseUp ? 1.0 : 1.04,
                          end: _pulseUp ? 1.04 : 1.0,
                        ),
                        duration: const Duration(milliseconds: 850),
                        curve: Curves.easeInOut,
                        onEnd: () {
                          if (!mounted) {
                            return;
                          }
                          setState(() {
                            _pulseUp = !_pulseUp;
                          });
                        },
                        builder: (context, scale, child) {
                          return Transform.scale(scale: scale, child: child);
                        },
                        child: ElevatedButton.icon(
                          onPressed: _startCookingFlow,
                          icon: const Icon(Icons.play_arrow_rounded),
                          label: const Text('Cocinar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF4D2D),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
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
                        children: widget.recipe.steps.asMap().entries.map((entry) {
                          final index = entry.key;
                          final step = entry.value;
                          final isLast = index == widget.recipe.steps.length - 1;
                          return _StepTimelineItem(
                            index: index,
                            step: step,
                            isLast: isLast,
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

class _StepTimelineItem extends StatelessWidget {
  final int index;
  final String step;
  final bool isLast;

  const _StepTimelineItem({
    required this.index,
    required this.step,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF4B5563),
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: const Color(0xFFE5E7EB),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                step,
                style: const TextStyle(
                  color: Color(0xFF374151),
                  height: 1.42,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CookingLoadingDialog extends StatelessWidget {
  const _CookingLoadingDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.96, end: 1.04),
              duration: const Duration(milliseconds: 650),
              curve: Curves.easeInOut,
              builder: (context, scale, child) {
                return Transform.scale(scale: scale, child: child);
              },
              onEnd: () {},
              child: CircleAvatar(
                radius: 44,
                backgroundColor: const Color(0xFFF3F4F6),
                child: Image.asset(
                  'assets/img/Chefcito_CompletoGorroBlanco.png',
                  width: 62,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Preparando cocina...',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'El chef esta organizando tus pasos.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF6B7280)),
            ),
            const SizedBox(height: 12),
            const SizedBox(
              width: 130,
              child: LinearProgressIndicator(
                minHeight: 7,
                color: Color(0xFFFF4D2D),
                backgroundColor: Color(0xFFE5E7EB),
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
