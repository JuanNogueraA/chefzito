import 'dart:typed_data';

import 'package:chefzito/models/recipe_model.dart';

abstract class RecipePort {
  Future<void> init();

  String get currentChefName;

  List<String> getCommonIngredients({int limit = 12});

  Future<List<String>> detectIngredientsFromImage(
    Uint8List imageBytes, {
    int maxIngredients = 10,
  });

  Future<Map<String, dynamic>?> generateRecipeFromIngredients(
    List<String> ingredients, {
    int maxSteps = 6,
  });

  List<RecipeModel> searchRecipesByIngredients(List<String> selectedIngredients);

  Future<String?> addRecipe({
    required String title,
    required String description,
    List<String> steps = const [],
    int prepTimeMin = 20,
    String difficulty = 'easy',
    Uint8List? coverBytes,
    bool generatedByAi = false,
  });

  RecipeModel getRecipe(String id);
}
