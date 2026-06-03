/// Modelo de datos que representa una Publicación (Post) en la comunidad.
class PostModel {
  /// Identificador único de la publicación.
  String id;
  /// Identificador del usuario que realizó la publicación.
  String userId;
  /// Identificador de la receta asociada a esta publicación, si la hay.
  String? recipeId;
  /// Descripción o texto (caption) que acompaña a la publicación.
  String description;
  /// URL del archivo multimedia (imagen o video) adjunto a la publicación.
  String? mediaUrl;
  /// Representación en base64 de la imagen, útil para subir archivos temporales.
  String? imageBase64;
  /// Cantidad de "Me gusta" que tiene la publicación.
  int likesCount;
  /// Indica si el usuario actual ha dado "Me gusta" a la publicación.
  bool likedByMe;
  /// Fecha y hora en que se creó la publicación.
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

  /// Factory constructor para crear una instancia de [PostModel] a partir de un JSON.
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      recipeId: json['recipe_id'] as String?,
      description: (json['caption'] as String?) ?? '',
      mediaUrl: json['media_url'] as String?,
      likesCount: (json['likes_count'] as int?) ?? 0,
      likedByMe: false, // Por defecto falso, se debe actualizar si hay lógica de likes de usuario
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  /// Convierte el [PostModel] a un mapa JSON para ser procesado por la base de datos o API.
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
