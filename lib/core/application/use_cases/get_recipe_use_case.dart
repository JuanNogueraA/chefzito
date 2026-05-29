import 'package:chefzito/core/domain/ports/recipe_port.dart';
import 'package:chefzito/models/recipe_model.dart';

class GetRecipeUseCase {
  final RecipePort _recipePort;

  GetRecipeUseCase(this._recipePort);

  RecipeModel call(String id) {
    return _recipePort.getRecipe(id);
  }
}
