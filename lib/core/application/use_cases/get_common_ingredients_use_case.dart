import 'package:chefzito/core/domain/ports/recipe_port.dart';

class GetCommonIngredientsUseCase {
  final RecipePort _recipePort;

  GetCommonIngredientsUseCase(this._recipePort);

  List<String> call({int limit = 12}) {
    return _recipePort.getCommonIngredients(limit: limit);
  }
}
