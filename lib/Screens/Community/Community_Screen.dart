import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:chefzito/core/application/use_cases/community_use_cases.dart';
import 'package:chefzito/core/infrastructure/supabase/supabase_chefzito_adapter.dart';
import 'package:chefzito/Widgets/NavBar.dart';
import 'package:chefzito/Widgets/Community_Screen_Widgets/Community_Header.dart';
import 'package:chefzito/Widgets/Community_Screen_Widgets/Comments_Bottom_Sheet.dart';
import 'package:chefzito/Widgets/Community_Screen_Widgets/Friends_Stories.dart';
import 'package:chefzito/Widgets/Community_Screen_Widgets/Create_Post_Modal.dart';
import 'package:chefzito/Widgets/Community_Screen_Widgets/Post_Card.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  bool isPublicTab = true;
  final SupabaseChefzitoAdapter _adapter = SupabaseChefzitoAdapter();
  late final CommunityUseCases _useCases;
  late final Future<void> _loadFuture;

  String _displayChefName() {
    final raw = _useCases.chefName.trim();
    if (raw.isEmpty) {
      return 'Invitado';
    }
    return raw[0].toUpperCase() + raw.substring(1);
  }

  @override
  void initState() {
    super.initState();
    _useCases = CommunityUseCases(_adapter);
    _loadFuture = _useCases.init();
  }

  Color get primaryColor =>
      isPublicTab ? const Color(0xFFFF5E00) : const Color(0xFF8A2BE2);
  Color get secondaryColor =>
      isPublicTab ? const Color(0xFFFF2A55) : const Color(0xFF4169E1);

  String _timeAgo(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inDays > 0) return 'hace ${diff.inDays}d';
    if (diff.inHours > 0) return 'hace ${diff.inHours}h';
    if (diff.inMinutes > 0) return 'hace ${diff.inMinutes}min';
    return 'ahora';
  }

  Future<void> _createPost(CreatePostData data) async {
    final fallbackRecipeId = _useCases.getRecipes().isNotEmpty
        ? _useCases.getRecipes().first.id
        : null;
    final normalizedName = data.recipeName.trim();
    String? recipeId = _useCases.findRecipeIdByTitle(normalizedName);

    if (recipeId == null && normalizedName.isNotEmpty) {
      Uint8List? coverBytes;
      if (data.imageBase64 != null && data.imageBase64!.isNotEmpty) {
        try {
          coverBytes = base64Decode(data.imageBase64!);
        } catch (_) {
          coverBytes = null;
        }
      }

      final recipeSteps = data.steps.isNotEmpty
          ? data.steps
          : const [
              'Agrega los ingredientes principales y cocina con cuidado.',
              'Ajusta sal y condimentos al gusto antes de servir.',
            ];

      recipeId = await _useCases.addRecipe(
        title: normalizedName,
        description: data.description.isEmpty
            ? 'Receta creada en Chefzito'
            : data.description,
        steps: recipeSteps,
        prepTimeMin: data.prepTimeMin,
        difficulty: data.difficulty,
        coverBytes: coverBytes,
      );
    }

    recipeId ??= fallbackRecipeId;

    await _useCases.addPost(
      data.description.isEmpty ? 'Nueva publicación' : data.description,
      recipeId,
      imageBase64: data.imageBase64,
    );
    if (!mounted) return;
    setState(() {
      isPublicTab = data.isPublic;
    });
  }

  Future<void> _deletePost(String postId) async {
    await _useCases.deletePost(postId);
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _toggleFollow(String userId) async {
    await _useCases.toggleFollow(userId);
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _openComments(String postId) async {
    await showCommentsBottomSheet(
      context: context,
      useCases: _useCases,
      postId: postId,
      onCommentsChanged: () {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // nombre del usuario autenticado
          // 1. EL HEADER LIMPIO
          CommunityHeader(
            isPublicTab: isPublicTab,
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
            chefName: _displayChefName(),
            onTabChanged: (bool isPublic) {
              setState(() => isPublicTab = isPublic);
            },
          ),

          // 2. LA LISTA DE CONTENIDO
          Expanded(
            child: FutureBuilder<void>(
              future: _loadFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }

                final visiblePosts = isPublicTab
                    ? _useCases.getPublicPosts()
                    : _useCases.getFriendsPosts();
                final followingIds = _useCases.getFollowingUserIds();
                final mutualFollowIds = _useCases.getMutualFollowUserIds();

                return ListView(
                  padding: const EdgeInsets.all(0),
                  children: [
                    if (!isPublicTab)
                      FriendsStories(primaryColor: primaryColor),
                    if (visiblePosts.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            'No hay publicaciones disponibles',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ...visiblePosts.map((post) {
                      final user = _useCases.getUser(post.userId);
                      final recipe = post.recipeId != null
                          ? _useCases.getRecipe(post.recipeId!)
                          : null;
                      final isFollowing = followingIds.contains(post.userId);
                      final isMutual = mutualFollowIds.contains(post.userId);

                      final postImage = post.mediaUrl?.isNotEmpty == true
                          ? post.mediaUrl!
                          : (recipe?.coverImageUrl ??
                              'assets/img/Chefcito_corona.png');
                      return PostCard(
                        postId: post.id,
                        authorId: post.userId,
                        userName: user.username,
                        userHandle: '@${user.username}',
                        time: _timeAgo(post.createdAt),
                        recipeName: recipe?.title ?? 'Receta Chefzito',
                        likes: post.likesCount.toString(),
                        caption: post.description,
                        imageUrl: postImage,
                        imageBase64: post.imageBase64,
                        avatarUrl: user.avatarUrl,
                        isFollowing: isFollowing,
                        isMutualFollow: isMutual,
                        isLiked: post.likedByMe,
                        onLikePressed: () async {
                          await _useCases.toggleLike(post.id);
                          if (!mounted) return;
                          setState(() {});
                        },
                        onDeletePressed: () => _deletePost(post.id),
                        onCommentsPressed: () => _openComments(post.id),
                        onFollowPressed: () => _toggleFollow(post.userId),
                        isPrivate: !isPublicTab,
                      );
                    }),
                    const SizedBox(height: 80),
                  ],
                );
              },
            ),
          ),
        ],
      ),

      // 3. EL BOTÓN FLOTANTE CON EL MODAL IMPORTADO
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreatePostModal(
            context: context,
            isPublicTab: isPublicTab,
            primaryColor: primaryColor,
            secondaryColor: secondaryColor,
            onTabChanged: (bool isPublic) {
              setState(() => isPublicTab = isPublic);
            },
            onPublish: _createPost,
          );
        },
        backgroundColor: Colors.transparent,
        elevation: 4,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [primaryColor, secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),

      bottomNavigationBar: Navbar(),
    );
  }
}
