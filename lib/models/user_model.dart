/// Modelo de datos que representa a un Usuario en la aplicación.
class UserModel {
  /// Identificador único del usuario (normalmente proviene de Supabase Auth).
  String id;
  /// Nombre de usuario para mostrar en la interfaz.
  String username;
  /// Correo electrónico del usuario.
  String email;
  /// Contraseña (se utiliza localmente en el registro; en DB suele manejarse por Supabase Auth).
  String password;
  /// URL de la imagen de perfil del usuario.
  String avatarUrl;
  /// Biografía o descripción corta del usuario.
  String bio;
  /// Cantidad de seguidores.
  int followersCount;
  /// Cantidad de usuarios a los que sigue.
  int followingCount;
  /// Fecha y hora en que se creó la cuenta.
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

  /// Factory constructor para crear un [UserModel] a partir de un mapa JSON (por ejemplo, desde la base de datos).
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

  /// Convierte el [UserModel] a un mapa JSON para ser enviado a la base de datos.
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
