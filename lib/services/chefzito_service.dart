import 'dart:convert';
import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/supabase_client.dart';
import '../models/comment_model.dart';
import '../models/follow_model.dart';
import '../models/post_model.dart';
import '../models/recipe_model.dart';
import '../models/trend_model.dart';
import '../models/user_model.dart';

// Servicio conectado a Supabase
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

  String? _currentUserId;

  SupabaseClient get _client => SupabaseClientProvider.client;

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

  String? get currentUserId => _currentUserId;

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

  String? get _effectiveCurrentUserId {
    final id = _currentUserId;
    if (id != null) {
      return id;
    }
    if (users.isNotEmpty) {
      return users.first.id;
    }
    return null;
  }

  Future<void> _loadCurrentUser() async {
    _currentUserId = _client.auth.currentUser?.id;
  }

  // Carga datos iniciales desde Supabase
  Future<void> init() async {
    if (loaded) return;

    await _loadCurrentUser();

    final usersResponse = await _client.from('users').select();
    users = (usersResponse as List)
        .map((user) => UserModel.fromJson(user as Map<String, dynamic>))
        .toList();

    final recipesResponse = await _client.from('recipes').select();
    final stepsResponse = await _client.from('recipe_steps').select();

    final stepsByRecipe = <String, List<String>>{};
    for (final row in stepsResponse as List) {
      final map = row as Map<String, dynamic>;
      final recipeId = map['recipe_id'] as String;
      final instruction = (map['instruction'] as String?) ?? '';
      stepsByRecipe.putIfAbsent(recipeId, () => []).add(instruction);
    }

    recipes = (recipesResponse as List)
        .map((recipe) {
          final map = recipe as Map<String, dynamic>;
          return RecipeModel.fromJson(
            map,
            steps: stepsByRecipe[map['id'] as String] ?? const [],
          );
        })
        .toList();

    final postsResponse = await _client
        .from('posts')
        .select()
        .order('created_at', ascending: false);
    posts = (postsResponse as List)
        .map((post) => PostModel.fromJson(post as Map<String, dynamic>))
        .toList();

    final commentsResponse = await _client
        .from('post_comments')
        .select()
        .order('created_at', ascending: true);
    comments = (commentsResponse as List)
        .map((comment) => CommentModel.fromJson(comment as Map<String, dynamic>))
        .toList();

    final followsResponse = await _client.from('user_follows').select();
    follows = (followsResponse as List)
        .map((follow) => FollowModel.fromJson(follow as Map<String, dynamic>))
        .toList();

    trends = [];

    loaded = true;

    // Log temporal para verificar conexión con Supabase.
    print(
      'Supabase OK: users=${users.length}, recipes=${recipes.length}, posts=${posts.length}, comments=${comments.length}',
    );
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    final cleanEmail = email.trim().toLowerCase();
    final cleanPassword = password.trim();

    if (cleanEmail.isEmpty || cleanPassword.isEmpty) {
      return 'Completa email y contraseña.';
    }

    try {
      final response = await _client.auth.signInWithPassword(
        email: cleanEmail,
        password: cleanPassword,
      );
      _currentUserId = response.user?.id;
      await init();
      return null;
    } on AuthException catch (error) {
      return error.message;
    } catch (_) {
      return 'No fue posible iniciar sesión.';
    }
  }

  Future<String?> register({
    required String username,
    required String email,
    required String password,
  }) async {
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

    final usernameNoSpaces = cleanName.toLowerCase().replaceAll(' ', '');

    try {
      final response = await _client.auth.signUp(
        email: cleanEmail,
        password: cleanPassword,
      );

      final userId = response.user?.id;
      if (userId != null) {
        await _client.from('users').update({
          'username': usernameNoSpaces,
          'full_name': cleanName,
        }).eq('id', userId);
      }

      _currentUserId = userId;
      await init();
      return null;
    } on AuthException catch (error) {
      return error.message;
    } catch (_) {
      return 'No fue posible crear la cuenta.';
    }
  }

  Future<void> logout() async {
    await _client.auth.signOut();
    _currentUserId = null;
  }

  Future<String?> uploadAvatar(Uint8List bytes) async {
    final userId = _effectiveCurrentUserId;
    if (userId == null) {
      return null;
    }

    final filePath = 'user_$userId/avatar_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final url = await _uploadImage(
      bucket: 'avatars',
      filePath: filePath,
      bytes: bytes,
    );

    if (url == null) {
      return null;
    }

    await _client.from('users').update({'avatar_url': url}).eq('id', userId);

    for (final user in users) {
      if (user.id == userId) {
        user.avatarUrl = url;
        break;
      }
    }

    return url;
  }

  // READ
  List<PostModel> getPosts() => posts;

  List<RecipeModel> getRecipes() => recipes;

  List<UserModel> getUsers() => users;

  List<String> getCommonIngredients({int limit = 12}) {
    final extracted = <String>{};

    for (final recipe in recipes) {
      extracted.addAll(_extractIngredientsFromRecipe(recipe));
    }

    final prettyExtracted = extracted.map(_capitalizeIngredient).toList()
      ..sort();

    if (prettyExtracted.isEmpty) {
      for (final ingredient in _fallbackIngredients) {
        if (!prettyExtracted.contains(ingredient)) {
          prettyExtracted.add(ingredient);
        }
      }
    }

    return prettyExtracted.take(limit).toList();
  }

  Future<List<String>> detectIngredientsFromImage(
    Uint8List imageBytes, {
    int maxIngredients = 10,
  }) async {
    final encoded = base64Encode(imageBytes);
    final response = await _client.functions.invoke(
      'gemini-proxy',
      body: {
        'imageBase64': encoded,
        'mimeType': 'image/jpeg',
        'maxIngredients': maxIngredients,
      },
    );

    if (response.status >= 400) {
      throw Exception('Error IA: ${response.status}');
    }

    dynamic payload = response.data;
    if (payload is String) {
      payload = jsonDecode(payload);
    }

    if (payload is! Map<String, dynamic>) {
      return [];
    }

    final candidates = payload['candidates'];
    if (candidates is! List || candidates.isEmpty) {
      return [];
    }

    final content = candidates.first is Map<String, dynamic>
        ? (candidates.first as Map<String, dynamic>)['content']
        : null;
    if (content is! Map<String, dynamic>) {
      return [];
    }

    final parts = content['parts'];
    if (parts is! List || parts.isEmpty) {
      return [];
    }

    final text = parts.first is Map<String, dynamic>
        ? (parts.first as Map<String, dynamic>)['text']
        : null;
    if (text is! String || text.trim().isEmpty) {
      return [];
    }

    dynamic decoded;
    try {
      decoded = jsonDecode(text);
    } catch (_) {
      return [];
    }

    if (decoded is! Map<String, dynamic>) {
      return [];
    }

    final ingredients = decoded['ingredients'];
    if (ingredients is! List) {
      return [];
    }

    return ingredients
        .whereType<String>()
        .map(_capitalizeIngredient)
        .where((ingredient) => ingredient.isNotEmpty)
        .toSet()
        .take(maxIngredients)
        .toList();
  }

  Future<Map<String, dynamic>?> generateRecipeFromIngredients(
    List<String> ingredients, {
    int maxSteps = 6,
  }) async {
    if (ingredients.isEmpty) {
      return null;
    }

    final response = await _client.functions.invoke(
      'gemini-proxy',
      body: {
        'mode': 'recipe',
        'ingredients': ingredients,
        'maxSteps': maxSteps,
      },
    );

    if (response.status >= 400) {
      throw Exception('Error IA: ${response.status}');
    }

    dynamic payload = response.data;
    if (payload is String) {
      payload = jsonDecode(payload);
    }

    if (payload is! Map<String, dynamic>) {
      return null;
    }

    final candidates = payload['candidates'];
    if (candidates is! List || candidates.isEmpty) {
      return null;
    }

    final content = candidates.first is Map<String, dynamic>
        ? (candidates.first as Map<String, dynamic>)['content']
        : null;
    if (content is! Map<String, dynamic>) {
      return null;
    }

    final parts = content['parts'];
    if (parts is! List || parts.isEmpty) {
      return null;
    }

    final text = parts.first is Map<String, dynamic>
        ? (parts.first as Map<String, dynamic>)['text']
        : null;
    if (text is! String || text.trim().isEmpty) {
      return null;
    }

    dynamic decoded;
    try {
      decoded = jsonDecode(text);
    } catch (_) {
      return null;
    }

    if (decoded is! Map<String, dynamic>) {
      return null;
    }

    final title = (decoded['title'] as String?)?.trim() ?? '';
    final description = (decoded['description'] as String?)?.trim() ?? '';
    final prepTime = decoded['prepTimeMin'];
    final difficulty = (decoded['difficulty'] as String?)?.trim() ?? 'easy';
    final stepsRaw = decoded['steps'];
    final ingredientsRaw = decoded['ingredients'];

    final steps = stepsRaw is List
        ? stepsRaw.whereType<String>().map((step) => step.trim()).where((s) => s.isNotEmpty).toList()
        : <String>[];
    final ingredientList = ingredientsRaw is List
        ? ingredientsRaw
            .whereType<String>()
            .map(_capitalizeIngredient)
            .where((item) => item.isNotEmpty)
            .toList()
        : <String>[];

    return {
      'title': title.isEmpty ? 'Receta Chefzito' : title,
      'description': description.isEmpty ? 'Receta creada con IA en Chefzito.' : description,
      'prepTimeMin': prepTime is int ? prepTime : int.tryParse(prepTime?.toString() ?? '') ?? 20,
      'difficulty': difficulty.isEmpty ? 'easy' : difficulty,
      'steps': steps.isEmpty
          ? const [
              'Prepara los ingredientes y corta en porciones medianas.',
              'Cocina a fuego medio hasta lograr el punto deseado.',
              'Sirve caliente y disfruta.',
            ]
          : steps,
      'ingredients': ingredientList,
    };
  }

  List<MapEntry<String, int>> getIngredientRanking({int limit = 8}) {
    final counts = <String, int>{};

    for (final recipe in recipes) {
      for (final ingredient in _extractIngredientsFromRecipe(recipe)) {
        final pretty = _capitalizeIngredient(ingredient);
        counts[pretty] = (counts[pretty] ?? 0) + 1;
      }
    }

    final entries = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return entries.take(limit).toList();
  }

  List<RecipeModel> searchRecipesByIngredients(
    List<String> selectedIngredients,
  ) {
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

  UserModel getUser(String id) {
    return users.firstWhere((u) => u.id == id);
  }

  RecipeModel getRecipe(String id) {
    return recipes.firstWhere((r) => r.id == id);
  }

  String? findRecipeIdByTitle(String title) {
    for (final recipe in recipes) {
      if (recipe.title.toLowerCase().trim() == title.toLowerCase().trim()) {
        return recipe.id;
      }
    }
    return null;
  }

  List<CommentModel> getCommentsByPost(String postId) {
    return comments.where((c) => c.postId == postId).toList();
  }

  Set<String> getFollowingUserIds() {
    if (!isAuthenticated) {
      return <String>{};
    }

    final currentUserId = _effectiveCurrentUserId;
    if (currentUserId == null) {
      return <String>{};
    }
    final followingIds = <String>{};
    for (final follow in follows) {
      if (follow.followerId == currentUserId) {
        followingIds.add(follow.followingId);
      }
    }
    return followingIds;
  }

  Set<String> getMutualFollowUserIds() {
    if (!isAuthenticated) {
      return <String>{};
    }

    final currentUserId = _effectiveCurrentUserId;
    if (currentUserId == null) {
      return <String>{};
    }
    final followingIds = <String>{};
    final followerIds = <String>{};

    for (final follow in follows) {
      if (follow.followerId == currentUserId) {
        followingIds.add(follow.followingId);
      }
      if (follow.followingId == currentUserId) {
        followerIds.add(follow.followerId);
      }
    }

    return followingIds.intersection(followerIds);
  }

  bool isFollowing(String userId) {
    return getFollowingUserIds().contains(userId);
  }

  bool isFollowedBy(String userId) {
    if (!isAuthenticated) {
      return false;
    }
    final currentUserId = _effectiveCurrentUserId;
    if (currentUserId == null) {
      return false;
    }
    return follows.any(
      (follow) =>
          follow.followerId == userId &&
          follow.followingId == currentUserId,
    );
  }

  bool isMutualFollow(String userId) {
    return getMutualFollowUserIds().contains(userId);
  }

  Future<void> toggleFollow(String userId) async {
    if (!isAuthenticated) {
      return;
    }
    final currentUserId = _effectiveCurrentUserId;
    if (currentUserId == null) {
      return;
    }

    final index = follows.indexWhere(
      (follow) =>
          follow.followerId == currentUserId &&
          follow.followingId == userId,
    );

    if (index != -1) {
      await _client.from('user_follows').delete().match({
        'follower_id': currentUserId,
        'following_id': userId,
      });
      follows.removeAt(index);
    } else {
      await _client.from('user_follows').insert({
        'follower_id': currentUserId,
        'following_id': userId,
      });
      follows.add(
        FollowModel(followerId: currentUserId, followingId: userId),
      );
    }
  }

  List<PostModel> getPublicPosts() {
    final mutualFollowIds = getMutualFollowUserIds();
    return posts
        .where((post) => !mutualFollowIds.contains(post.userId))
        .toList();
  }

  List<PostModel> getFriendsPosts() {
    final mutualFollowIds = getMutualFollowUserIds();
    return posts
        .where((post) => mutualFollowIds.contains(post.userId))
        .toList();
  }

  // CREATE
  Future<void> addPost(
    String description,
    String? recipeId, {
    String? imageBase64,
  }) async {
    final userId = _effectiveCurrentUserId;
    if (userId == null) {
      return;
    }

    String? mediaUrl;
    if (imageBase64 != null && imageBase64.isNotEmpty) {
      try {
        final bytes = base64Decode(imageBase64);
        final filePath =
            'user_$userId/post_${DateTime.now().millisecondsSinceEpoch}.jpg';
        mediaUrl = await _uploadImage(
          bucket: 'posts',
          filePath: filePath,
          bytes: bytes,
        );
      } catch (_) {
        mediaUrl = null;
      }
    }

    final response = await _client
        .from('posts')
        .insert({
          'user_id': userId,
          'recipe_id': recipeId,
          'caption': description,
          'media_url': mediaUrl,
        })
        .select()
        .single();

    final newPost = PostModel.fromJson(response);
    newPost.mediaUrl = mediaUrl;
    posts.insert(0, newPost);
  }

  Future<String?> addRecipe({
    required String title,
    required String description,
    List<String> steps = const [],
    int prepTimeMin = 20,
    String difficulty = 'easy',
    Uint8List? coverBytes,
    bool generatedByAi = false,
  }) async {
    final userId = _effectiveCurrentUserId;
    if (userId == null) {
      return null;
    }

    try {
      String? coverUrl;
      if (coverBytes != null && coverBytes.isNotEmpty) {
        final filePath =
            'user_$userId/recipe_${DateTime.now().millisecondsSinceEpoch}.jpg';
        coverUrl = await _uploadImage(
          bucket: 'recipes',
          filePath: filePath,
          bytes: coverBytes,
        );
      }

      final response = await _client
          .from('recipes')
          .insert({
            'author_id': userId,
            'title': title,
            'description': description,
            'cover_image_url': coverUrl ?? '',
            'prep_time_min': prepTimeMin,
            'difficulty': difficulty,
            'ai_generated': generatedByAi,
          })
          .select()
          .single();

      final newRecipe = RecipeModel.fromJson(response, steps: steps);
      recipes.insert(0, newRecipe);

      if (steps.isNotEmpty) {
        final stepPayload = List.generate(
          steps.length,
          (index) => {
            'recipe_id': newRecipe.id,
            'step_number': index + 1,
            'instruction': steps[index],
          },
        );
        await _client.from('recipe_steps').insert(stepPayload);
      }

      return newRecipe.id;
    } catch (_) {
      return null;
    }
  }

  Future<String?> _uploadImage({
    required String bucket,
    required String filePath,
    required Uint8List bytes,
  }) async {
    try {
      await _client.storage.from(bucket).uploadBinary(
            filePath,
            bytes,
            fileOptions: const FileOptions(
              upsert: true,
              contentType: 'image/jpeg',
            ),
          );

      return _client.storage.from(bucket).getPublicUrl(filePath);
    } catch (_) {
      return null;
    }
  }

  Future<void> addComment(String postId, String content) async {
    final userId = _effectiveCurrentUserId;
    if (userId == null) {
      return;
    }

    final response = await _client
        .from('post_comments')
        .insert({
          'post_id': postId,
          'user_id': userId,
          'comment': content,
        })
        .select()
        .single();

    comments.add(CommentModel.fromJson(response));
  }

  // UPDATE
  Future<void> updatePost(String postId, String newDescription) async {
    final index = posts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      posts[index].description = newDescription;
      await _client.from('posts').update({
        'caption': newDescription,
      }).eq('id', postId);
    }
  }

  // DELETE
  Future<void> deletePost(String postId) async {
    await _client.from('posts').delete().eq('id', postId);
    await _client.from('post_comments').delete().eq('post_id', postId);
    posts.removeWhere((p) => p.id == postId);
    comments.removeWhere((c) => c.postId == postId);
  }

  // LIKE
  Future<void> toggleLike(String postId) async {
    final post = posts.firstWhere((p) => p.id == postId);
    final userId = _effectiveCurrentUserId;
    if (userId == null) {
      return;
    }
    if (post.likedByMe) {
      if (post.likesCount > 0) {
        post.likesCount -= 1;
      }
      post.likedByMe = false;
      await _client.from('post_likes').delete().match({
        'user_id': userId,
        'post_id': postId,
      });
    } else {
      post.likesCount += 1;
      post.likedByMe = true;
      await _client.from('post_likes').insert({
        'user_id': userId,
        'post_id': postId,
      });
    }

    await _client.from('posts').update({
      'likes_count': post.likesCount,
    }).eq('id', postId);
  }

  Set<String> _extractIngredientsFromRecipe(RecipeModel recipe) {
    final source =
        '${recipe.title} ${recipe.description} ${recipe.steps.join(' ')}'
            .toLowerCase();
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
