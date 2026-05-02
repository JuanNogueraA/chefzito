class CommentModel {
  int id;
  int postId;
  int userId;
  String content;
  DateTime createdAt;

  CommentModel({
    required this.id,
    required this.postId,
    required this.userId,
    required this.content,
    required this.createdAt,
  });
}
