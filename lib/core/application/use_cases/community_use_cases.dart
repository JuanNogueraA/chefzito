import 'dart:typed_data';

import 'package:chefzito/core/domain/ports/community_port.dart';
import 'package:chefzito/models/comment_model.dart';
import 'package:chefzito/models/post_model.dart';
import 'package:chefzito/models/recipe_model.dart';
import 'package:chefzito/models/user_model.dart';

class CommunityUseCases {
  final CommunityPort _port;

  CommunityUseCases(this._port);

  Future<void> init() => _port.init();

  String get chefName => _port.currentChefName;

  List<PostModel> getPublicPosts() => _port.getPublicPosts();

  List<PostModel> getFriendsPosts() => _port.getFriendsPosts();

  Set<String> getFollowingUserIds() => _port.getFollowingUserIds();

  Set<String> getMutualFollowUserIds() => _port.getMutualFollowUserIds();

  List<RecipeModel> getRecipes() => _port.getRecipes();

  UserModel getUser(String id) => _port.getUser(id);

  RecipeModel getRecipe(String id) => _port.getRecipe(id);

  String? findRecipeIdByTitle(String title) => _port.findRecipeIdByTitle(title);

  Future<void> addPost(
    String description,
    String? recipeId, {
    String? imageBase64,
  }) =>
      _port.addPost(description, recipeId, imageBase64: imageBase64);

  Future<String?> addRecipe({
    required String title,
    required String description,
    List<String> steps = const [],
    int prepTimeMin = 20,
    String difficulty = 'easy',
    Uint8List? coverBytes,
    bool generatedByAi = false,
  }) =>
      _port.addRecipe(
        title: title,
        description: description,
        steps: steps,
        prepTimeMin: prepTimeMin,
        difficulty: difficulty,
        coverBytes: coverBytes,
        generatedByAi: generatedByAi,
      );

  Future<void> deletePost(String postId) => _port.deletePost(postId);

  Future<void> toggleFollow(String userId) => _port.toggleFollow(userId);

  Future<void> toggleLike(String postId) => _port.toggleLike(postId);

  List<CommentModel> getCommentsByPost(String postId) =>
      _port.getCommentsByPost(postId);

  Future<void> addComment(String postId, String content) =>
      _port.addComment(postId, content);
}
