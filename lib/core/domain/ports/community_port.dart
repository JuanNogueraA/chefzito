import 'dart:typed_data';

import 'package:chefzito/core/domain/ports/chef_name_port.dart';
import 'package:chefzito/core/domain/ports/init_port.dart';
import 'package:chefzito/models/comment_model.dart';
import 'package:chefzito/models/post_model.dart';
import 'package:chefzito/models/recipe_model.dart';
import 'package:chefzito/models/user_model.dart';

abstract class CommunityPort implements InitPort, ChefNamePort {
  List<PostModel> getPublicPosts();

  List<PostModel> getFriendsPosts();

  Set<String> getFollowingUserIds();

  Set<String> getMutualFollowUserIds();

  List<RecipeModel> getRecipes();

  UserModel getUser(String id);

  RecipeModel getRecipe(String id);

  String? findRecipeIdByTitle(String title);

  Future<void> addPost(
    String description,
    String? recipeId, {
    String? imageBase64,
  });

  Future<String?> addRecipe({
    required String title,
    required String description,
    List<String> steps = const [],
    int prepTimeMin = 20,
    String difficulty = 'easy',
    Uint8List? coverBytes,
    bool generatedByAi = false,
  });

  Future<void> deletePost(String postId);

  Future<void> toggleFollow(String userId);

  Future<void> toggleLike(String postId);

  List<CommentModel> getCommentsByPost(String postId);

  Future<void> addComment(String postId, String content);
}
