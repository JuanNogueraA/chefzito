class PostModel {
  int id;
  int userId;
  int recipeId;
  String description;
  String? imageBase64;
  int likesCount;
  bool likedByMe;
  DateTime createdAt;

  PostModel({
    required this.id,
    required this.userId,
    required this.recipeId,
    required this.description,
    this.imageBase64,
    required this.likesCount,
    this.likedByMe = false,
    required this.createdAt,
  });
}
