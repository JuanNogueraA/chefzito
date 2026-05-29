import 'package:chefzito/core/domain/ports/recipe_port.dart';

class GenerateRecipeUseCase {
  final RecipePort _recipePort;

  GenerateRecipeUseCase(this._recipePort);

  Future<Map<String, dynamic>?> call(
    List<String> ingredients, {
    int maxSteps = 6,
  }) {
    return _recipePort.generateRecipeFromIngredients(
      ingredients,
      maxSteps: maxSteps,
    );
  }
}
