class UserModel {
  int id;
  String username;
  String email;
  String avatarUrl;
  DateTime createdAt;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.avatarUrl,
    required this.createdAt,
  });
}
