class RecipeModel {
  int id;
  int authorId;
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
}
