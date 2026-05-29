import 'package:chefzito/core/domain/ports/rankings_port.dart';
import 'package:chefzito/models/post_model.dart';
import 'package:chefzito/models/recipe_model.dart';
import 'package:chefzito/models/user_model.dart';

class RankingsUseCases {
  final RankingsPort _port;

  RankingsUseCases(this._port);

  Future<void> init() => _port.init();

  String get chefName => _port.currentChefName;

  List<PostModel> getPosts() => _port.getPosts();

  List<RecipeModel> getRecipes() => _port.getRecipes();

  List<UserModel> getUsers() => _port.getUsers();

  List<MapEntry<String, int>> getIngredientRanking({int limit = 8}) =>
      _port.getIngredientRanking(limit: limit);
}
