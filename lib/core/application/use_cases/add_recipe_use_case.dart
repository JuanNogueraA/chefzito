import 'dart:typed_data';

import 'package:chefzito/core/domain/ports/recipe_port.dart';

class AddRecipeUseCase {
  final RecipePort _recipePort;

  AddRecipeUseCase(this._recipePort);

  Future<String?> call({
    required String title,
    required String description,
    List<String> steps = const [],
    int prepTimeMin = 20,
    String difficulty = 'easy',
    Uint8List? coverBytes,
    bool generatedByAi = false,
  }) {
    return _recipePort.addRecipe(
      title: title,
      description: description,
      steps: steps,
      prepTimeMin: prepTimeMin,
      difficulty: difficulty,
      coverBytes: coverBytes,
      generatedByAi: generatedByAi,
    );
  }
}
