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
  static final ChefzitoService _instance = ChefzitoService._internal();

  factory ChefzitoService() {
    return _instance;
  }

  ChefzitoService._internal();

  List<PostModel> posts = [];
  List<UserModel> users = [];
  List<CommentModel> comments = [];
  List<FollowModel> follows = [];
  List<RecipeModel> recipes = [];
  List<TrendModel> trends = [];

  int? _currentUserId;

  final List<String> _ingredientVocabulary = [
    'pollo',
    'pasta',
    'tomate',
    'cebolla',
    'ajo',
    'arroz',
    'huevo',
    'huevos',
    'queso',
    'leche',
    'pan',
    'aceite',
    'sal',
    'res',
    'carne',
    'tortilla',
    'vegetales',
    'salsa',
  ];

  final List<String> _fallbackIngredients = const [
    'Pollo',
    'Pasta',
    'Tomate',
    'Cebolla',
    'Ajo',
    'Arroz',
    'Huevos',
    'Queso',
    'Leche',
    'Pan',
    'Aceite',
    'Sal',
  ];

  bool loaded = false;

  int? get currentUserId => _currentUserId;

  bool get isAuthenticated => _currentUserId != null;

  UserModel? get currentUser {
    final id = _currentUserId;
    if (id == null) {
      return null;
    }

    for (final user in users) {
      if (user.id == id) {
        return user;
      }
    }
    return null;
  }

  String get currentChefName {
    return currentUser?.username ?? 'Invitado';
  }

  int get _effectiveCurrentUserId {
    final id = _currentUserId;
    if (id != null) {
      return id;
    }
    if (users.isNotEmpty) {
      return users.first.id;
    }
    return 1;
  }

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
            password: u['password'] ?? '',
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

  Future<String?> login({required String email, required String password}) async {
    await init();

    final cleanEmail = email.trim().toLowerCase();
    final cleanPassword = password.trim();

    if (cleanEmail.isEmpty || cleanPassword.isEmpty) {
      return 'Completa email y contraseña.';
    }

    UserModel? matched;
    for (final user in users) {
      if (user.email.toLowerCase().trim() == cleanEmail && user.password == cleanPassword) {
        matched = user;
        break;
      }
    }

    if (matched == null) {
      return 'Credenciales inválidas.';
    }

    _currentUserId = matched.id;
    return null;
  }

  Future<String?> register({
    required String username,
    required String email,
    required String password,
  }) async {
    await init();

    final cleanName = username.trim();
    final cleanEmail = email.trim().toLowerCase();
    final cleanPassword = password.trim();

    if (cleanName.isEmpty || cleanEmail.isEmpty || cleanPassword.isEmpty) {
      return 'Completa todos los campos.';
    }

    if (!cleanEmail.contains('@') || !cleanEmail.contains('.')) {
      return 'Ingresa un email válido.';
    }

    if (cleanPassword.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres.';
    }

    final alreadyExists = users.any(
      (user) => user.email.toLowerCase().trim() == cleanEmail,
    );

    if (alreadyExists) {
      return 'Ese email ya está registrado.';
    }

    final nextId = users.isEmpty
        ? 1
        : users.map((user) => user.id).reduce((a, b) => a > b ? a : b) + 1;

    final usernameNoSpaces = cleanName.toLowerCase().replaceAll(' ', '');

    final newUser = UserModel(
      id: nextId,
      username: usernameNoSpaces,
      email: cleanEmail,
      password: cleanPassword,
      avatarUrl: 'assets/img/avatar1.png',
      createdAt: DateTime.now(),
    );

    users.add(newUser);
    _currentUserId = newUser.id;
    return null;
  }

  void logout() {
    _currentUserId = null;
  }

  // READ
  List<PostModel> getPosts() => posts;

  List<RecipeModel> getRecipes() => recipes;

  List<String> getCommonIngredients({int limit = 12}) {
    final extracted = <String>{};

    for (final recipe in recipes) {
      extracted.addAll(_extractIngredientsFromRecipe(recipe));
    }

    final prettyExtracted = extracted.map(_capitalizeIngredient).toList()..sort();

    for (final ingredient in _fallbackIngredients) {
      if (!prettyExtracted.contains(ingredient)) {
        prettyExtracted.add(ingredient);
      }
    }

    return prettyExtracted.take(limit).toList();
  }

  List<RecipeModel> searchRecipesByIngredients(List<String> selectedIngredients) {
    if (selectedIngredients.isEmpty) {
      return List<RecipeModel>.from(recipes);
    }

    final normalizedSelected = selectedIngredients
        .map(_normalizeIngredient)
        .where((i) => i.isNotEmpty)
        .toSet();

    final scored = <MapEntry<RecipeModel, int>>[];

    for (final recipe in recipes) {
      final recipeIngredients = _extractIngredientsFromRecipe(recipe);
      final matches = normalizedSelected
          .where((ingredient) => recipeIngredients.contains(ingredient))
          .length;

      if (matches > 0) {
        scored.add(MapEntry(recipe, matches));
      }
    }

    scored.sort((a, b) {
      final scoreCompare = b.value.compareTo(a.value);
      if (scoreCompare != 0) {
        return scoreCompare;
      }
      return a.key.prepTimeMin.compareTo(b.key.prepTimeMin);
    });

    return scored.map((entry) => entry.key).toList();
  }

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
    if (!isAuthenticated) {
      return false;
    }
    return follows.any(
      (follow) =>
          follow.followerId == _effectiveCurrentUserId && follow.followingId == userId,
    );
  }

  bool isFollowedBy(int userId) {
    if (!isAuthenticated) {
      return false;
    }
    return follows.any(
      (follow) =>
          follow.followerId == userId && follow.followingId == _effectiveCurrentUserId,
    );
  }

  bool isMutualFollow(int userId) {
    return isFollowing(userId) && isFollowedBy(userId);
  }

  void toggleFollow(int userId) {
    if (!isAuthenticated) {
      return;
    }

    final index = follows.indexWhere(
      (follow) =>
          follow.followerId == _effectiveCurrentUserId && follow.followingId == userId,
    );

    if (index != -1) {
      follows.removeAt(index);
    } else {
      follows.add(
        FollowModel(followerId: _effectiveCurrentUserId, followingId: userId),
      );
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
    final userId = _effectiveCurrentUserId;
    posts.add(
      PostModel(
        id: posts.isEmpty ? 1 : posts.last.id + 1,
        userId: userId,
        recipeId: recipeId,
        description: description,
        likesCount: 0,
        likedByMe: false,
        createdAt: DateTime.now(),
      ),
    );
  }

  void addComment(int postId, String content) {
    final userId = _effectiveCurrentUserId;
    comments.add(
      CommentModel(
        id: comments.isEmpty ? 1 : comments.last.id + 1,
        postId: postId,
        userId: userId,
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

  Set<String> _extractIngredientsFromRecipe(RecipeModel recipe) {
    final source =
        '${recipe.title} ${recipe.description} ${recipe.steps.join(' ')}'.toLowerCase();
    final found = <String>{};

    for (final keyword in _ingredientVocabulary) {
      if (source.contains(keyword)) {
        found.add(_normalizeIngredient(keyword));
      }
    }

    return found;
  }

  String _normalizeIngredient(String value) {
    var normalized = value.toLowerCase().trim();
    normalized = normalized
        .replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ú', 'u');

    if (normalized == 'huevo') {
      return 'huevos';
    }

    return normalized;
  }

  String _capitalizeIngredient(String value) {
    final normalized = _normalizeIngredient(value);
    if (normalized.isEmpty) {
      return normalized;
    }
    return normalized[0].toUpperCase() + normalized.substring(1);
  }
}
