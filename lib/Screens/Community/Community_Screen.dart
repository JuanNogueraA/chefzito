import 'package:flutter/material.dart';
import 'package:chefzito/services/chefzito_service.dart';
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
  final ChefzitoService _service = ChefzitoService();
  late final Future<void> _loadFuture;

  String _displayChefName() {
    final raw = _service.currentChefName.trim();
    if (raw.isEmpty) {
      return 'Invitado';
    }
    return raw[0].toUpperCase() + raw.substring(1);
  }

  @override
  void initState() {
    super.initState();
    _loadFuture = _service.init();
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

  void _createPost(CreatePostData data) {
    final recipeId = _service.findRecipeIdByTitle(data.recipeName) ?? 1;

    setState(() {
      _service.addPost(
        data.description.isEmpty ? 'Nueva publicación' : data.description,
        recipeId,
      );
      isPublicTab = data.isPublic;
    });
  }

  void _deletePost(int postId) {
    setState(() {
      _service.deletePost(postId);
    });
  }

  void _toggleFollow(int userId) {
    setState(() {
      _service.toggleFollow(userId);
    });
  }

  Future<void> _openComments(int postId) async {
    await showCommentsBottomSheet(
      context: context,
      service: _service,
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

                final allPosts = _service.getPosts();
                final visiblePosts = isPublicTab
                    ? _service.getPublicPosts()
                    : _service.getFriendsPosts();

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
                      final user = _service.getUser(post.userId);
                      final recipe = _service.getRecipe(post.recipeId);
                      final isFollowing = _service.isFollowing(post.userId);
                      final isMutual = _service.isMutualFollow(post.userId);

                      return PostCard(
                        postId: post.id,
                        authorId: post.userId,
                        userName: user.username,
                        userHandle: '@${user.username}',
                        time: _timeAgo(post.createdAt),
                        recipeName: recipe.title,
                        likes: post.likesCount.toString(),
                        caption: post.description,
                        imageUrl: recipe.coverImageUrl,
                        isFollowing: isFollowing,
                        isMutualFollow: isMutual,
                        isLiked: post.likedByMe,
                        onLikePressed: () {
                          setState(() {
                            _service.toggleLike(post.id);
                          });
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