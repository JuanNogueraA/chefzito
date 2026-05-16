class PostModel {
  String id;
  String userId;
  String? recipeId;
  String description;
  String? mediaUrl;
  String? imageBase64;
  int likesCount;
  bool likedByMe;
  DateTime createdAt;

  PostModel({
    required this.id,
    required this.userId,
    required this.recipeId,
    required this.description,
    this.mediaUrl,
    this.imageBase64,
    required this.likesCount,
    this.likedByMe = false,
    required this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      recipeId: json['recipe_id'] as String?,
      description: (json['caption'] as String?) ?? '',
      mediaUrl: json['media_url'] as String?,
      likesCount: (json['likes_count'] as int?) ?? 0,
      likedByMe: false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'recipe_id': recipeId,
      'caption': description,
      'media_url': mediaUrl,
      'likes_count': likesCount,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
