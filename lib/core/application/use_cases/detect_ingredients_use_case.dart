import 'dart:typed_data';

import 'package:chefzito/core/domain/ports/recipe_port.dart';

class DetectIngredientsUseCase {
  final RecipePort _recipePort;

  DetectIngredientsUseCase(this._recipePort);

  Future<List<String>> call(
    Uint8List imageBytes, {
    int maxIngredients = 10,
  }) {
    return _recipePort.detectIngredientsFromImage(
      imageBytes,
      maxIngredients: maxIngredients,
    );
  }
}
