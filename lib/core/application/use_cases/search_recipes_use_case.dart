import 'package:chefzito/core/domain/ports/recipe_port.dart';
import 'package:chefzito/models/recipe_model.dart';

class SearchRecipesUseCase {
  final RecipePort _recipePort;

  SearchRecipesUseCase(this._recipePort);

  List<RecipeModel> call(List<String> selectedIngredients) {
    return _recipePort.searchRecipesByIngredients(selectedIngredients);
  }
}
