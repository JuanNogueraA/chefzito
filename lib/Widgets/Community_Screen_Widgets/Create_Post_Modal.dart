import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'Privacy_Option.dart';

class CreatePostData {
  final bool isPublic;
  final String recipeName;
  final String description;
  final String? imageBase64;
  final List<String> steps;
  final int prepTimeMin;
  final String difficulty;

  const CreatePostData({
    required this.isPublic,
    required this.recipeName,
    required this.description,
    this.imageBase64,
    this.steps = const [],
    this.prepTimeMin = 20,
    this.difficulty = 'easy',
  });
}

Future<void> showCreatePostModal({
  required BuildContext context,
  required bool isPublicTab,
  required Color primaryColor,
  required Color secondaryColor,
  required ValueChanged<bool> onTabChanged,
  required ValueChanged<CreatePostData> onPublish,
}) async {
  final imagePicker = ImagePicker();
  final recipeController = TextEditingController();
  final descriptionController = TextEditingController();
  final prepTimeController = TextEditingController(text: '20');
  final stepController = TextEditingController();
  Uint8List? selectedImageBytes;
  String? selectedImageBase64;
  String? selectedImageName;
  String selectedDifficulty = 'easy';
  final List<String> steps = [];

  void addStep(StateSetter setModalState) {
    final step = stepController.text.trim();
    if (step.isEmpty) {
      return;
    }
    setModalState(() {
      steps.add(step);
      stepController.clear();
    });
  }

  void removeStep(StateSetter setModalState, int index) {
    setModalState(() {
      steps.removeAt(index);
    });
  }

  Future<void> pickImage(StateSetter setModalState) async {
    final image = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1600,
    );

    if (image == null) {
      return;
    }

    final bytes = await image.readAsBytes();
    setModalState(() {
      selectedImageBytes = bytes;
      selectedImageBase64 = base64Encode(bytes);
      selectedImageName = image.name;
    });
  }

  void clearSelectedImage(StateSetter setModalState) {
    setModalState(() {
      selectedImageBytes = null;
      selectedImageBase64 = null;
      selectedImageName = null;
    });
  }

  final postData = await showModalBottomSheet<CreatePostData>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (modalContext) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          final mediaQuery = MediaQuery.of(context);
          final size = mediaQuery.size;
          final isWide = size.width >= 520;
          final imageHeight = isWide ? 220.0 : 180.0;
          return SafeArea(
            child: Container(
              height: size.height * 0.9,
              margin: const EdgeInsets.only(top: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, secondaryColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Crear Publicación',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(modalContext),
                        child: const Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Privacidad de la publicación',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 15),
                        if (isWide)
                          Row(
                            children: [
                              Expanded(
                                child: PrivacyOption(
                                  icon: Icons.public,
                                  title: 'Público',
                                  subtitle: 'Todos pueden ver',
                                  isActive: isPublicTab,
                                  color: const Color(0xFFFF5E00),
                                  onTap: () {
                                    setModalState(() => isPublicTab = true);
                                    onTabChanged(true);
                                  },
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: PrivacyOption(
                                  icon: Icons.people_alt_outlined,
                                  title: 'Solo Amigos',
                                  subtitle: 'Solo tus amigos',
                                  isActive: !isPublicTab,
                                  color: const Color(0xFF8A2BE2),
                                  onTap: () {
                                    setModalState(() => isPublicTab = false);
                                    onTabChanged(false);
                                  },
                                ),
                              ),
                            ],
                          )
                        else
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              PrivacyOption(
                                icon: Icons.public,
                                title: 'Público',
                                subtitle: 'Todos pueden ver',
                                isActive: isPublicTab,
                                color: const Color(0xFFFF5E00),
                                onTap: () {
                                  setModalState(() => isPublicTab = true);
                                  onTabChanged(true);
                                },
                              ),
                              const SizedBox(height: 12),
                              PrivacyOption(
                                icon: Icons.people_alt_outlined,
                                title: 'Solo Amigos',
                                subtitle: 'Solo tus amigos',
                                isActive: !isPublicTab,
                                color: const Color(0xFF8A2BE2),
                                onTap: () {
                                  setModalState(() => isPublicTab = false);
                                  onTabChanged(false);
                                },
                              ),
                            ],
                          ),
                        const SizedBox(height: 25),
                        const Text(
                          'Foto de tu platillo',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => pickImage(setModalState),
                          child: Container(
                            height: imageHeight,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[50],
                            ),
                            child: selectedImageBytes == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera_alt_outlined,
                                        size: 40,
                                        color: Colors.grey[400],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Toca para subir foto',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'JPG, PNG hasta 10MB',
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(13),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image.memory(
                                          selectedImageBytes!,
                                          fit: BoxFit.cover,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black.withValues(
                                                  alpha: 0.06,
                                                ),
                                                Colors.black.withValues(
                                                  alpha: 0.34,
                                                ),
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 12,
                                          right: 12,
                                          bottom: 12,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  selectedImageName ??
                                                      'Foto seleccionada',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () => clearSelectedImage(
                                                  setModalState,
                                                ),
                                                child: Container(
                                                  padding: const EdgeInsets.all(
                                                    8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withValues(
                                                          alpha: 0.45,
                                                        ),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.close,
                                                    size: 18,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          'Nombre de la receta',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: recipeController,
                          decoration: InputDecoration(
                            hintText: 'Ej: Pasta Carbonara',
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          'Detalles de la receta',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (isWide)
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: prepTimeController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Tiempo (min)'
                                        .trim(),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    prefixIcon: const Icon(Icons.schedule),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: selectedDifficulty,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    prefixIcon: const Icon(Icons.star_outline),
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'easy',
                                      child: Text('Fácil'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'medium',
                                      child: Text('Media'),
                                    ),
                                    DropdownMenuItem(
                                      value: 'hard',
                                      child: Text('Difícil'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    if (value == null) return;
                                    setModalState(() {
                                      selectedDifficulty = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          )
                        else
                          Column(
                            children: [
                              TextField(
                                controller: prepTimeController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'Tiempo (min)',
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: const Icon(Icons.schedule),
                                ),
                              ),
                              const SizedBox(height: 12),
                              DropdownButtonFormField<String>(
                                value: selectedDifficulty,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: const Icon(Icons.star_outline),
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'easy',
                                    child: Text('Fácil'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'medium',
                                    child: Text('Media'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'hard',
                                    child: Text('Difícil'),
                                  ),
                                ],
                                onChanged: (value) {
                                  if (value == null) return;
                                  setModalState(() {
                                    selectedDifficulty = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        const SizedBox(height: 25),
                        const Text(
                          'Pasos de preparación',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: stepController,
                                decoration: InputDecoration(
                                  hintText: 'Ej: Cocinar la pasta al dente',
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                onSubmitted: (_) => addStep(setModalState),
                              ),
                            ),
                            const SizedBox(width: 10),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              curve: Curves.easeOut,
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: IconButton(
                                onPressed: () => addStep(setModalState),
                                icon: const Icon(Icons.add, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 260),
                          curve: Curves.easeOut,
                          child: steps.isEmpty
                              ? AnimatedOpacity(
                                  duration: const Duration(milliseconds: 240),
                                  opacity: 0.6,
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[50],
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.grey[200]!)),
                                    child: const Text(
                                      'Agrega al menos 2 pasos para que la receta quede completa.',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                )
                              : Column(
                                  children: steps.asMap().entries.map((entry) {
                                    final index = entry.key;
                                    final step = entry.value;
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.grey[200]!,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 26,
                                            height: 26,
                                            decoration: BoxDecoration(
                                              color: primaryColor.withValues(
                                                alpha: 0.12,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              '${index + 1}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              step,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () =>
                                                removeStep(setModalState, index),
                                            icon: const Icon(
                                              Icons.close,
                                              size: 18,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          'Descripción',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: descriptionController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Cuéntanos sobre tu platillo...',
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            final parsedPrep = int.tryParse(
                                  prepTimeController.text.trim(),
                                ) ??
                                20;
                            final data = CreatePostData(
                              isPublic: isPublicTab,
                              recipeName: recipeController.text.trim(),
                              description: descriptionController.text.trim(),
                              imageBase64: selectedImageBase64,
                              steps: List<String>.from(steps),
                              prepTimeMin: parsedPrep,
                              difficulty: selectedDifficulty,
                            );
                            Navigator.pop(modalContext, data);
                          },
                          child: Container(
                            width: double.infinity,
                            height: 55,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  primaryColor.withOpacity(0.6),
                                  secondaryColor.withOpacity(0.6),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  isPublicTab
                                      ? 'Publicar Públicamente'
                                      : 'Publicar para Amigos',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
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
        },
      );
    },
  );

  if (postData != null) {
    onPublish(postData);
  }
}
