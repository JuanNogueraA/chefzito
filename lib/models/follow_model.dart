/// Modelo de datos que representa una relación de seguimiento entre dos usuarios.
class FollowModel {
  /// Identificador del usuario que sigue a otro (el seguidor).
  String followerId;
  /// Identificador del usuario que es seguido (el objetivo).
  String followingId;

  FollowModel({required this.followerId, required this.followingId});

  /// Factory constructor para crear una instancia de [FollowModel] a partir de un JSON.
  factory FollowModel.fromJson(Map<String, dynamic> json) {
    return FollowModel(
      followerId: json['follower_id'] as String,
      followingId: json['following_id'] as String,
    );
  }

  /// Convierte el [FollowModel] a un mapa JSON para ser procesado por la base de datos o API.
  Map<String, dynamic> toJson() {
    return {
      'follower_id': followerId,
      'following_id': followingId,
    };
  }
}
