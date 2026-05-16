class RecipeModel {
  String id;
  String authorId;
  String title;
  String description;
  String coverImageUrl;
  List<String> steps;
  int prepTimeMin;
  String difficulty;
  bool generatedByAi;

  RecipeModel({
    required this.id,
    required this.authorId,
    required this.title,
    required this.description,
    required this.coverImageUrl,
    required this.steps,
    required this.prepTimeMin,
    required this.difficulty,
    required this.generatedByAi,
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
      difficulty: (json['difficulty'] as String?) ?? 'easy',
      generatedByAi: (json['ai_generated'] as bool?) ?? false,
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
      'difficulty': difficulty,
      'ai_generated': generatedByAi,
    };
  }
}
