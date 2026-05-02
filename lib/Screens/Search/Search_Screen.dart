import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chefzito/Screens/Search/Search_Results_Screen.dart';
import 'package:chefzito/Widgets/NavBar.dart';
import 'package:chefzito/services/chefzito_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ChefzitoService _service = ChefzitoService();
  final TextEditingController _ingredientController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  late final Future<void> _loadFuture;
  final List<String> _selectedIngredients = [];
  final List<String> _iaDetectedIngredients = [];

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
  void dispose() {
    _ingredientController.dispose();
    super.dispose();
  }

  void _addIngredient(String rawValue) {
    final value = rawValue.trim();
    if (value.isEmpty) {
      return;
    }

    final exists = _selectedIngredients.any(
      (item) => item.toLowerCase() == value.toLowerCase(),
    );

    if (exists) {
      return;
    }

    setState(() {
      _selectedIngredients.add(value);
    });
    _ingredientController.clear();
  }

  void _removeIngredient(String value) {
    setState(() {
      _selectedIngredients.remove(value);
      _iaDetectedIngredients.removeWhere(
        (item) => item.toLowerCase() == value.toLowerCase(),
      );
    });
  }

  void _toggleCommonIngredient(String ingredient) {
    final exists = _selectedIngredients.any(
      (item) => item.toLowerCase() == ingredient.toLowerCase(),
    );

    setState(() {
      if (exists) {
        _selectedIngredients.removeWhere(
          (item) => item.toLowerCase() == ingredient.toLowerCase(),
        );
        _iaDetectedIngredients.removeWhere(
          (item) => item.toLowerCase() == ingredient.toLowerCase(),
        );
      } else {
        _selectedIngredients.add(ingredient);
      }
    });
  }

  Future<void> _simulateAiDetection() async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1400,
    );

    if (!mounted || image == null) {
      return;
    }

    Uint8List? imageBytes;
    try {
      imageBytes = await image.readAsBytes();
    } catch (_) {
      imageBytes = null;
    }

    await _showAiAnalysisDialog(image.path, imageBytes);

    if (!mounted) {
      return;
    }

    final detected = _mockDetectedIngredients();
    final selectedLower = _selectedIngredients.map((i) => i.toLowerCase()).toSet();

    setState(() {
      _iaDetectedIngredients.clear();
      _iaDetectedIngredients.addAll(detected);

      for (final ingredient in detected) {
        if (!selectedLower.contains(ingredient.toLowerCase())) {
          _selectedIngredients.add(ingredient);
        }
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('IA simulada: detectamos ${detected.length} ingredientes.'),
      ),
    );
  }

  List<String> _mockDetectedIngredients() {
    final fromCommon = _service.getCommonIngredients(limit: 12);
    final preferred = ['Tomate', 'Cebolla', 'Ajo', 'Pollo', 'Pimiento', 'Zanahoria'];
    final fallback = ['Brocoli', 'Pasta'];

    final detected = <String>[];

    for (final ingredient in preferred) {
      if (!detected.contains(ingredient)) {
        detected.add(ingredient);
      }
    }

    for (final ingredient in fromCommon) {
      if (!detected.any((d) => d.toLowerCase() == ingredient.toLowerCase())) {
        detected.add(ingredient);
      }
      if (detected.length >= 7) {
        break;
      }
    }

    for (final ingredient in fallback) {
      if (!detected.any((d) => d.toLowerCase() == ingredient.toLowerCase())) {
        detected.add(ingredient);
      }
      if (detected.length >= 7) {
        break;
      }
    }

    return detected.take(7).toList();
  }

  Future<void> _showAiAnalysisDialog(String imagePath, Uint8List? imageBytes) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (kIsWeb)
                      SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: imageBytes != null
                            ? Image.memory(imageBytes, fit: BoxFit.cover)
                            : Container(
                                color: const Color(0xFFBFC4CF),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.image_not_supported,
                                  size: 44,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    if (!kIsWeb)
                      Image.file(
                        File(imagePath),
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    Container(
                      height: 180,
                      color: Colors.black.withValues(alpha: 0.32),
                    ),
                    const Column(
                      children: [
                        Text('⭐', style: TextStyle(fontSize: 38)),
                        SizedBox(height: 2),
                        Text(
                          'Analizando con IA...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 31 / 1.45,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: const Color(0xFFF5F6FC),
                      child: Image.asset(
                        'assets/img/Chefcito_CompletoGorroBlanco.png',
                        width: 74,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Detectando ingredientes',
                      style: TextStyle(
                        fontSize: 32 / 1.4,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Nuestra IA está analizando tu foto...',
                      style: TextStyle(color: Color(0xFF6B7280), fontSize: 16),
                    ),
                    const SizedBox(height: 14),
                    const _AiStepRow(label: 'Procesando imagen'),
                    const SizedBox(height: 10),
                    const _AiStepRow(label: 'Identificando objetos'),
                    const SizedBox(height: 10),
                    const _AiStepRow(label: 'Reconociendo ingredientes'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

    await Future.delayed(const Duration(seconds: 5));

    if (!mounted) {
      return;
    }

    Navigator.of(context, rootNavigator: true).pop();
  }

  void _openResultsScreen() {
    if (_selectedIngredients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona al menos un ingrediente.')),
      );
      return;
    }

    final selected = List<String>.from(_selectedIngredients);
    final recipes = _service.searchRecipesByIngredients(selected);

    Navigator.of(context).push(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 360),
        reverseTransitionDuration: const Duration(milliseconds: 280),
        pageBuilder: (context, animation, secondaryAnimation) {
          return SearchResultsScreen(
            selectedIngredients: selected,
            recipes: recipes,
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
      backgroundColor: const Color(0xFFF3F4FA),
      body: FutureBuilder<void>(
        future: _loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final commonIngredients = _service.getCommonIngredients();
          final chefName = _displayChefName();

          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: 24,
                  bottom: _selectedIngredients.isEmpty ? 30 : 110,
                ),
                child: Column(
                  children: [
                    Container(
                      width: 132,
                      height: 132,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/img/Chefcito_CompletoGorroBlanco.png',
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Chef $chefName, elige tus ingredientes 👨‍🍳',
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '¿Qué tienes en casa?',
                      style: TextStyle(
                        fontSize: 43 / 1.5,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Añade tus ingredientes o escanéalos con la cámara',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24 / 1.5, color: Color(0xFF6B7280)),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF9146FF), Color(0xFFFF2B9A)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF9146FF).withValues(alpha: 0.24),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                _GradientMiniIcon(icon: Icons.camera_alt_rounded),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Escaneo Inteligente con IA',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 28 / 1.5,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        'Toma una foto de tus ingredientes',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 22 / 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              child: InkWell(
                                onTap: _simulateAiDetection,
                                borderRadius: BorderRadius.circular(14),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.camera_alt, color: Color(0xFF8B2CF5)),
                                      SizedBox(width: 8),
                                      Text('📸 Escanear Ingredientes'),
                                      SizedBox(width: 4),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 34),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(height: 1.2, color: const Color(0xFFD1D5DB)),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: Text(
                              'O escribe manualmente',
                              style: TextStyle(
                                color: Color(0xFF6B7280),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(height: 1.2, color: const Color(0xFFD1D5DB)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF9FAFB),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: const Color(0xFFD1D5DB)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _ingredientController,
                                      onSubmitted: _addIngredient,
                                      decoration: const InputDecoration(
                                        hintText: 'Ej: Pollo, tomate, pasta...',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  const Icon(Icons.search_rounded, color: Color(0xFF9CA3AF)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Material(
                            color: const Color(0xFFF5A76C),
                            borderRadius: BorderRadius.circular(24),
                            child: InkWell(
                              onTap: () => _addIngredient(_ingredientController.text),
                              borderRadius: BorderRadius.circular(24),
                              child: const SizedBox(
                                width: 46,
                                height: 46,
                                child: Icon(Icons.add, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 260),
                      child: _iaDetectedIngredients.isEmpty
                          ? const SizedBox(height: 0)
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(20, 16, 20, 2),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: const Color(0xFFE5E7EB)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '✨ Tus ingredientes (${_iaDetectedIngredients.length})',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF374151),
                                        fontSize: 31 / 1.5,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: _iaDetectedIngredients
                                          .map(
                                            (ingredient) => _DetectedChip(
                                              label: ingredient,
                                              onDeleted: () => _removeIngredient(ingredient),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ingredientes comunes:',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF374151),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: commonIngredients
                                .map(
                                  (ingredient) => _IngredientChip(
                                    label: ingredient,
                                    selected: _selectedIngredients.any(
                                      (item) =>
                                          item.toLowerCase() == ingredient.toLowerCase(),
                                    ),
                                    onTap: () => _toggleCommonIngredient(ingredient),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: Column(
                        children: [
                          const Text('🍲', style: TextStyle(fontSize: 82)),
                          const SizedBox(height: 8),
                          Text(
                            'Selecciona tus ingredientes y pulsa Buscar Recetas para ver platillos recomendados.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (_selectedIngredients.isNotEmpty)
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 18,
                  child: SafeArea(
                    top: false,
                    child: Material(
                      color: const Color(0xFFFF4D2D),
                      borderRadius: BorderRadius.circular(16),
                      elevation: 8,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: _openResultsScreen,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Text(
                            'Buscar recetas (${_selectedIngredients.length} ingredientes) →',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
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

// Widget para los chips de ingredientes
class _IngredientChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _IngredientChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(13),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFD1FAE5) : const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: selected ? const Color(0xFF34D399) : const Color(0xFFD1D5DB),
              width: 1.2,
            ),
          ),
          child: Text(
            selected ? '✓ $label' : label,
            style: TextStyle(
              color: selected ? const Color(0xFF059669) : const Color(0xFF111827),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _DetectedChip extends StatelessWidget {
  final String label;
  final VoidCallback onDeleted;

  const _DetectedChip({required this.label, required this.onDeleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF2E6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFEA580C),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onDeleted,
            child: const Icon(Icons.close, size: 16, color: Color(0xFFEA580C)),
          ),
        ],
      ),
    );
  }
}

class _GradientMiniIcon extends StatelessWidget {
  final IconData icon;

  const _GradientMiniIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Colors.white),
    );
  }
}

class _AiStepRow extends StatelessWidget {
  final String label;

  const _AiStepRow({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EAF8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.circle, color: Color(0xFFA855F7), size: 10),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF374151),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ],
      ),
    );
  }
}
