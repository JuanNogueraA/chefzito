import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final int postId;
  final int authorId;
  final String userName;
  final String userHandle;
  final String time;
  final String recipeName;
  final String likes;
  final String caption;
  final String imageUrl;
  final bool isFollowing;
  final bool isMutualFollow;
  final bool isPrivate;
  final bool isLiked;
  final VoidCallback onLikePressed;
  final VoidCallback onDeletePressed;
  final VoidCallback onCommentsPressed;
  final VoidCallback onFollowPressed;

  const PostCard({
    Key? key,
    required this.postId,
    required this.authorId,
    required this.userName,
    required this.userHandle,
    required this.time,
    required this.recipeName,
    required this.likes,
    required this.caption,
    required this.imageUrl,
    required this.isFollowing,
    required this.isMutualFollow,
    required this.isLiked,
    required this.onLikePressed,
    required this.onDeletePressed,
    required this.onCommentsPressed,
    required this.onFollowPressed,
    this.isPrivate = false,
  }) : super(key: key);

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  void _handleMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'follow':
        onFollowPressed();
        _showMessage(context, 'Ahora sigues a $userName');
        break;
      case 'unfollow':
        onFollowPressed();
        _showMessage(context, 'Has dejado de seguir a $userName');
        break;
      case 'report':
        _showMessage(context, 'Publicación reportada');
        break;
      case 'share':
        Clipboard.setData(
          ClipboardData(text: '$userName compartió "$recipeName": $caption'),
        );
        _showMessage(context, 'Contenido copiado para compartir');
        break;
      case 'link':
        Clipboard.setData(
          ClipboardData(text: 'https://chefzito.app/publicaciones/$postId'),
        );
        _showMessage(context, 'Enlace copiado al portapapeles');
        break;
      case 'delete':
        onDeletePressed();
        break;
    }
  }

  Widget _buildPostImage() {
    final isNetwork =
        imageUrl.startsWith('http://') || imageUrl.startsWith('https://');

    if (isNetwork) {
      return Image.network(
        imageUrl,
        height: 300,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return Container(
            height: 300,
            width: double.infinity,
            color: Colors.grey[200],
            child: const Icon(Icons.image_not_supported, size: 50),
          );
        },
      );
    }

    return Image.asset(
      imageUrl,
      height: 300,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) {
        return Container(
          height: 300,
          width: double.infinity,
          color: Colors.grey[200],
          child: const Icon(Icons.image_not_supported, size: 50),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://randomuser.me/api/portraits/lego/1.jpg',
                  ),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "$userHandle • $time",
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),
                ),
                if (isMutualFollow && !isPrivate)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.person_add_alt_1,
                          color: Colors.green,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Amigo",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(width: 10),
                PopupMenuButton<String>(
                  onSelected: (value) => _handleMenuAction(context, value),
                  icon: const Icon(Icons.more_horiz, color: Colors.grey),
                  itemBuilder: (context) => [
                    PopupMenuItem<String>(
                      value: isFollowing ? 'unfollow' : 'follow',
                      child: Row(
                        children: [
                          Icon(
                            isFollowing
                                ? Icons.person_remove_alt_1
                                : Icons.person_add_alt_1,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(isFollowing ? 'Dejar de seguir' : 'Seguir'),
                        ],
                      ),
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem<String>(
                      value: 'report',
                      child: Row(
                        children: const [
                          Icon(Icons.flag_outlined, size: 18),
                          SizedBox(width: 8),
                          Text('Reportar publicación'),
                        ],
                      ),
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem<String>(
                      value: 'share',
                      child: Row(
                        children: const [
                          Icon(Icons.share_outlined, size: 18),
                          SizedBox(width: 8),
                          Text('Compartir'),
                        ],
                      ),
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem<String>(
                      value: 'link',
                      child: Row(
                        children: const [
                          Icon(Icons.link, size: 18),
                          SizedBox(width: 8),
                          Text('Compartir enlace'),
                        ],
                      ),
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: Row(
                        children: const [
                          Icon(
                            Icons.delete_outline,
                            size: 18,
                            color: Colors.red,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Eliminar publicación',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isPrivate
                      ? Colors.blue
                      : Colors.orange.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.menu_book,
                    size: 16,
                    color: isPrivate ? Colors.blue : Colors.orange,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    recipeName,
                    style: TextStyle(
                      color: isPrivate ? Colors.blue : Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            if (isPrivate)
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.lock_outline, size: 14, color: Colors.white),
                      SizedBox(width: 6),
                      Text(
                        "Solo Amigos",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: _buildPostImage(),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                GestureDetector(
                  onTap: onLikePressed,
                  child: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    size: 28,
                    color: isLiked ? Colors.red : Colors.black87,
                  ),
                ),
                const SizedBox(width: 15),
                GestureDetector(
                  onTap: onCommentsPressed,
                  child: const Icon(Icons.chat_bubble_outline, size: 26),
                ),
                const Spacer(),
                const Icon(Icons.bookmark_border, size: 28),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "$likes me gusta",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87, fontSize: 14),
                children: [
                  TextSpan(
                    text: "$userHandle ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: caption),
                ],
              ),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: onCommentsPressed,
              child: Text(
                "Ver los comentarios",
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
