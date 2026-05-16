class FollowModel {
  String followerId;
  String followingId;

  FollowModel({required this.followerId, required this.followingId});

  factory FollowModel.fromJson(Map<String, dynamic> json) {
    return FollowModel(
      followerId: json['follower_id'] as String,
      followingId: json['following_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'follower_id': followerId,
      'following_id': followingId,
    };
  }
}
