class RecipeModel {
  String id;
  String authorId;
  String title;
  String description;
  String coverImageUrl;
  List<String> steps;
  int prepTimeMin;
  int servings;
  String difficulty;
  bool generatedByAi;
  int likesCount;
  int savesCount;

  RecipeModel({
    required this.id,
    required this.authorId,
    required this.title,
    required this.description,
    required this.coverImageUrl,
    required this.steps,
    required this.prepTimeMin,
    this.servings = 1,
    required this.difficulty,
    required this.generatedByAi,
    this.likesCount = 0,
    this.savesCount = 0,
  });

  factory RecipeModel.fromJson(
    Map<String, dynamic> json, {
    List<String> steps = const [],
  }) {
    return RecipeModel(
      id: json['id'] as String,
      authorId: json['author_id'] as String,
      title: (json['title'] as String?) ?? '',
      description: (json['description'] as String?) ?? '',
      coverImageUrl: (json['cover_image_url'] as String?) ?? '',
      steps: steps,
      prepTimeMin: (json['prep_time_min'] as int?) ?? 0,
      servings: (json['servings'] as int?) ?? 1,
      difficulty: (json['difficulty'] as String?) ?? 'easy',
      generatedByAi: (json['ai_generated'] as bool?) ?? false,
      likesCount: (json['likes_count'] as int?) ?? 0,
      savesCount: (json['saves_count'] as int?) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author_id': authorId,
      'title': title,
      'description': description,
      'cover_image_url': coverImageUrl,
      'prep_time_min': prepTimeMin,
      'servings': servings,
      'difficulty': difficulty,
      'ai_generated': generatedByAi,
      'likes_count': likesCount,
      'saves_count': savesCount,
    };
  }
}
