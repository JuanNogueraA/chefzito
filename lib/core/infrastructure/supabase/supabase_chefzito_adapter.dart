import 'dart:typed_data';

import 'package:chefzito/core/domain/ports/auth_port.dart';
import 'package:chefzito/core/domain/ports/chef_name_port.dart';
import 'package:chefzito/core/domain/ports/community_port.dart';
import 'package:chefzito/core/domain/ports/home_port.dart';
import 'package:chefzito/core/domain/ports/init_port.dart';
import 'package:chefzito/core/domain/ports/profile_port.dart';
import 'package:chefzito/core/domain/ports/rankings_port.dart';
import 'package:chefzito/core/domain/ports/recipe_port.dart';
import 'package:chefzito/models/comment_model.dart';
import 'package:chefzito/models/post_model.dart';
import 'package:chefzito/models/trend_model.dart';
import 'package:chefzito/models/user_model.dart';
import 'package:chefzito/models/recipe_model.dart';
import 'package:chefzito/services/chefzito_service.dart';

class SupabaseChefzitoAdapter
    implements
        AuthPort,
        RecipePort,
        InitPort,
        ChefNamePort,
        CommunityPort,
        ProfilePort,
        HomePort,
        RankingsPort {
  final ChefzitoService _service = ChefzitoService();

  @override
  Future<void> init() {
    return _service.init();
  }

  @override
  String get currentChefName => _service.currentChefName;

  @override
  UserModel? get currentUser => _service.currentUser;

  @override
  Future<String?> login({
    required String email,
    required String password,
  }) {
    return _service.login(email: email, password: password);
  }

  @override
  Future<String?> register({
    required String username,
    required String email,
    required String password,
  }) {
    return _service.register(
      username: username,
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() {
    return _service.logout();
  }

  @override
  List<String> getCommonIngredients({int limit = 12}) {
    return _service.getCommonIngredients(limit: limit);
  }

  @override
  Future<List<String>> detectIngredientsFromImage(
    Uint8List imageBytes, {
    int maxIngredients = 10,
  }) {
    return _service.detectIngredientsFromImage(
      imageBytes,
      maxIngredients: maxIngredients,
    );
  }

  @override
  Future<Map<String, dynamic>?> generateRecipeFromIngredients(
    List<String> ingredients, {
    int maxSteps = 6,
  }) {
    return _service.generateRecipeFromIngredients(
      ingredients,
      maxSteps: maxSteps,
    );
  }

  @override
  List<RecipeModel> searchRecipesByIngredients(
    List<String> selectedIngredients,
  ) {
    return _service.searchRecipesByIngredients(selectedIngredients);
  }

  @override
  Future<String?> addRecipe({
    required String title,
    required String description,
    List<String> steps = const [],
    int prepTimeMin = 20,
    String difficulty = 'easy',
    Uint8List? coverBytes,
    bool generatedByAi = false,
  }) {
    return _service.addRecipe(
      title: title,
      description: description,
      steps: steps,
      prepTimeMin: prepTimeMin,
      difficulty: difficulty,
      coverBytes: coverBytes,
      generatedByAi: generatedByAi,
    );
  }

  @override
  RecipeModel getRecipe(String id) {
    return _service.getRecipe(id);
  }

  @override
  List<PostModel> getPosts() {
    return _service.getPosts();
  }

  @override
  List<RecipeModel> getRecipes() {
    return _service.getRecipes();
  }

  @override
  List<UserModel> getUsers() {
    return _service.getUsers();
  }

  @override
  List<TrendModel> getTrends() {
    return _service.getTrends();
  }

  @override
  List<MapEntry<String, int>> getIngredientRanking({int limit = 8}) {
    return _service.getIngredientRanking(limit: limit);
  }

  @override
  List<PostModel> getPublicPosts() {
    return _service.getPublicPosts();
  }

  @override
  List<PostModel> getFriendsPosts() {
    return _service.getFriendsPosts();
  }

  @override
  Set<String> getFollowingUserIds() {
    return _service.getFollowingUserIds();
  }

  @override
  Set<String> getMutualFollowUserIds() {
    return _service.getMutualFollowUserIds();
  }

  @override
  UserModel getUser(String id) {
    return _service.getUser(id);
  }

  @override
  String? findRecipeIdByTitle(String title) {
    return _service.findRecipeIdByTitle(title);
  }

  @override
  Future<void> addPost(
    String description,
    String? recipeId, {
    String? imageBase64,
  }) {
    return _service.addPost(
      description,
      recipeId,
      imageBase64: imageBase64,
    );
  }

  @override
  Future<void> deletePost(String postId) {
    return _service.deletePost(postId);
  }

  @override
  Future<void> toggleFollow(String userId) {
    return _service.toggleFollow(userId);
  }

  @override
  Future<void> toggleLike(String postId) {
    return _service.toggleLike(postId);
  }

  @override
  List<CommentModel> getCommentsByPost(String postId) {
    return _service.getCommentsByPost(postId);
  }

  @override
  Future<void> addComment(String postId, String content) {
    return _service.addComment(postId, content);
  }

  @override
  Future<String?> uploadAvatar(Uint8List bytes) {
    return _service.uploadAvatar(bytes);
  }
}
