class UserModel {
  String id;
  String username;
  String email;
  String password;
  String avatarUrl;
  String bio;
  int followersCount;
  int followingCount;
  DateTime createdAt;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.avatarUrl,
    this.bio = '',
    this.followersCount = 0,
    this.followingCount = 0,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: (json['username'] as String?) ?? '',
      email: (json['email'] as String?) ?? '',
      password: (json['password'] as String?) ?? '',
      avatarUrl: (json['avatar_url'] as String?) ?? '',
      bio: (json['bio'] as String?) ?? '',
      followersCount: (json['followers_count'] as int?) ?? 0,
      followingCount: (json['following_count'] as int?) ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'avatar_url': avatarUrl,
      'bio': bio,
      'followers_count': followersCount,
      'following_count': followingCount,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
