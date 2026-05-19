import 'package:chefzito/core/domain/ports/home_port.dart';
import 'package:chefzito/models/post_model.dart';
import 'package:chefzito/models/recipe_model.dart';
import 'package:chefzito/models/trend_model.dart';

class HomeUseCases {
  final HomePort _port;

  HomeUseCases(this._port);

  Future<void> init() => _port.init();

  String get chefName => _port.currentChefName;

  List<PostModel> getPosts() => _port.getPosts();

  List<RecipeModel> getRecipes() => _port.getRecipes();

  List<TrendModel> getTrends() => _port.getTrends();
}
