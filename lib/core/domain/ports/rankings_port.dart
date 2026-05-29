import 'package:chefzito/core/domain/ports/chef_name_port.dart';
import 'package:chefzito/core/domain/ports/init_port.dart';
import 'package:chefzito/models/post_model.dart';
import 'package:chefzito/models/recipe_model.dart';
import 'package:chefzito/models/user_model.dart';

abstract class RankingsPort implements InitPort, ChefNamePort {
  List<PostModel> getPosts();

  List<RecipeModel> getRecipes();

  List<UserModel> getUsers();

  List<MapEntry<String, int>> getIngredientRanking({int limit = 8});
}
