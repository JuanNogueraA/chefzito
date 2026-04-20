class PostModel {
  int id;
  int userId;
  int recipeId;
  String description;
  int likesCount;
  bool likedByMe;
  DateTime createdAt;

  PostModel({
    required this.id,
    required this.userId,
    required this.recipeId,
    required this.description,
    required this.likesCount,
    this.likedByMe = false,
    required this.createdAt,
  });
}
