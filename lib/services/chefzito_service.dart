import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/comment_model.dart';
import '../models/follow_model.dart';
import '../models/post_model.dart';
import '../models/recipe_model.dart';
import '../models/trend_model.dart';
import '../models/user_model.dart';

// Servicio que simula backend con JSON + memoria
class ChefzitoService {
  List<PostModel> posts = [];
  List<UserModel> users = [];
  List<CommentModel> comments = [];
  List<FollowModel> follows = [];
  List<RecipeModel> recipes = [];
  List<TrendModel> trends = [];

  final int currentUserId = 1;

  bool loaded = false;

  // Carga datos iniciales desde assets
  Future<void> init() async {
    if (loaded) return;

    final response = await rootBundle.loadString(
      'assets/data/chefzito_data.json',
    );
    final data = json.decode(response);

    users = (data['usuarios'] as List)
        .map(
          (u) => UserModel(
            id: u['id'],
            username: u['username'],
            email: u['email'],
            avatarUrl: u['avatar_url'],
            createdAt: DateTime.parse(u['created_at']),
          ),
        )
        .toList();

    recipes = (data['recetas'] as List)
        .map(
          (r) => RecipeModel(
            id: r['id'],
            authorId: r['author_id'],
            title: r['title'],
            description: r['description'],
            coverImageUrl: r['cover_image_url'],
            steps: List<String>.from(r['steps']),
            prepTimeMin: r['prep_time_min'],
            difficulty: r['difficulty'],
            generatedByAi: r['generated_by_ai'],
          ),
        )
        .toList();

    posts = (data['publicaciones'] as List)
        .map(
          (p) => PostModel(
            id: p['id'],
            userId: p['user_id'],
            recipeId: p['recipe_id'],
            description: p['description'],
            likesCount: p['likes_count'],
            likedByMe: false,
            createdAt: DateTime.parse(p['created_at']),
          ),
        )
        .toList();

    comments = (data['comentarios'] as List)
        .map(
          (c) => CommentModel(
            id: c['id'],
            postId: c['post_id'],
            userId: c['user_id'],
            content: c['content'],
            createdAt: DateTime.parse(c['created_at']),
          ),
        )
        .toList();

    follows =
        (data['seguimientos'] as List?)
            ?.map(
              (f) => FollowModel(
                followerId: f['follower_id'],
                followingId: f['following_id'],
              ),
            )
            .toList() ??
        [];

    trends = (data['tendencias'] as List)
        .map(
          (t) =>
              TrendModel(id: t['id'], hashtag: t['hashtag'], count: t['count']),
        )
        .toList();

    loaded = true;
  }

  // READ
  List<PostModel> getPosts() => posts;

  List<RecipeModel> getRecipes() => recipes;

  List<TrendModel> getTrends() => trends;

  UserModel getUser(int id) {
    return users.firstWhere((u) => u.id == id);
  }

  RecipeModel getRecipe(int id) {
    return recipes.firstWhere((r) => r.id == id);
  }

  int? findRecipeIdByTitle(String title) {
    for (final recipe in recipes) {
      if (recipe.title.toLowerCase().trim() == title.toLowerCase().trim()) {
        return recipe.id;
      }
    }
    return null;
  }

  List<CommentModel> getCommentsByPost(int postId) {
    return comments.where((c) => c.postId == postId).toList();
  }

  bool isFollowing(int userId) {
    return follows.any(
      (follow) =>
          follow.followerId == currentUserId && follow.followingId == userId,
    );
  }

  bool isFollowedBy(int userId) {
    return follows.any(
      (follow) =>
          follow.followerId == userId && follow.followingId == currentUserId,
    );
  }

  bool isMutualFollow(int userId) {
    return isFollowing(userId) && isFollowedBy(userId);
  }

  void toggleFollow(int userId) {
    final index = follows.indexWhere(
      (follow) =>
          follow.followerId == currentUserId && follow.followingId == userId,
    );

    if (index != -1) {
      follows.removeAt(index);
    } else {
      follows.add(FollowModel(followerId: currentUserId, followingId: userId));
    }
  }

  List<PostModel> getPublicPosts() {
    return posts.where((post) => !isMutualFollow(post.userId)).toList();
  }

  List<PostModel> getFriendsPosts() {
    return posts.where((post) => isMutualFollow(post.userId)).toList();
  }

  // CREATE
  void addPost(String description, int recipeId) {
    posts.add(
      PostModel(
        id: posts.isEmpty ? 1 : posts.last.id + 1,
        userId: 1,
        recipeId: recipeId,
        description: description,
        likesCount: 0,
        likedByMe: false,
        createdAt: DateTime.now(),
      ),
    );
  }

  void addComment(int postId, String content) {
    comments.add(
      CommentModel(
        id: comments.isEmpty ? 1 : comments.last.id + 1,
        postId: postId,
        userId: 1,
        content: content,
        createdAt: DateTime.now(),
      ),
    );
  }

  // UPDATE
  void updatePost(int postId, String newDescription) {
    final index = posts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      posts[index].description = newDescription;
    }
  }

  // DELETE
  void deletePost(int postId) {
    posts.removeWhere((p) => p.id == postId);
    comments.removeWhere((c) => c.postId == postId);
  }

  // LIKE
  void toggleLike(int postId) {
    final post = posts.firstWhere((p) => p.id == postId);
    if (post.likedByMe) {
      if (post.likesCount > 0) {
        post.likesCount -= 1;
      }
      post.likedByMe = false;
    } else {
      post.likesCount += 1;
      post.likedByMe = true;
    }
  }
}
