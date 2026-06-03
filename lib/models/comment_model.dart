/// Modelo de datos que representa un Comentario en una publicación de la comunidad.
class CommentModel {
  /// Identificador único del comentario.
  String id;
  /// Identificador de la publicación (Post) a la que pertenece el comentario.
  String postId;
  /// Identificador del usuario que escribió el comentario.
  String userId;
  /// Contenido en texto del comentario.
  String content;
  /// Fecha y hora en que se creó el comentario.
  DateTime createdAt;

  CommentModel({
    required this.id,
    required this.postId,
    required this.userId,
    required this.content,
    required this.createdAt,
  });

  /// Factory constructor para crear una instancia de [CommentModel] a partir de un JSON.
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String,
      postId: json['post_id'] as String,
      userId: json['user_id'] as String,
      content: (json['comment'] as String?) ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  /// Convierte el [CommentModel] a un mapa JSON para ser procesado por la base de datos o API.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'post_id': postId,
      'user_id': userId,
      'comment': content,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
