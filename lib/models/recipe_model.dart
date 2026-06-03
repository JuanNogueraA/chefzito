/// Modelo de datos que representa una Receta en la aplicación.
class RecipeModel {
  /// Identificador único de la receta.
  String id;
  /// Identificador del usuario creador (autor) de la receta.
  String authorId;
  /// Título de la receta.
  String title;
  /// Descripción breve de la receta.
  String description;
  /// URL de la imagen de portada de la receta.
  String coverImageUrl;
  /// Lista de los pasos (instrucciones) a seguir para preparar la receta.
  List<String> steps;
  /// Tiempo de preparación estimado en minutos.
  int prepTimeMin;
  /// Cantidad de porciones que rinde la receta.
  int servings;
  /// Nivel de dificultad (ej. 'easy', 'medium', 'hard').
  String difficulty;
  /// Indica si la receta fue generada utilizando Inteligencia Artificial.
  bool generatedByAi;
  /// Cantidad de "Me gusta" que ha recibido la receta.
  int likesCount;
  /// Cantidad de veces que la receta ha sido guardada por los usuarios.
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

  /// Crea una instancia de [RecipeModel] a partir de un mapa JSON.
  /// [steps] puede ser inyectado por separado ya que suele provenir de otra consulta (tabla relacionada).
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

  /// Convierte el [RecipeModel] a un mapa JSON para interactuar con la base de datos.
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
