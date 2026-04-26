class UserModel {
  int id;
  String username;
  String email;
  String password;
  String avatarUrl;
  DateTime createdAt;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.avatarUrl,
    required this.createdAt,
  });
}
