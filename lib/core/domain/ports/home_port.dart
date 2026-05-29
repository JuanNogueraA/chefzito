import 'package:chefzito/core/domain/ports/chef_name_port.dart';
import 'package:chefzito/core/domain/ports/init_port.dart';
import 'package:chefzito/models/post_model.dart';
import 'package:chefzito/models/recipe_model.dart';
import 'package:chefzito/models/trend_model.dart';

abstract class HomePort implements InitPort, ChefNamePort {
  List<PostModel> getPosts();

  List<RecipeModel> getRecipes();

  List<TrendModel> getTrends();
}
