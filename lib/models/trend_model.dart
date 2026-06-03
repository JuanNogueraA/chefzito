/// Modelo de datos que representa una Tendencia (Trend) en la plataforma, como un hashtag popular.
class TrendModel {
  /// Identificador único de la tendencia.
  int id;
  /// Texto del hashtag o tema en tendencia.
  String hashtag;
  /// Cantidad de veces que se ha utilizado o mencionado este hashtag.
  int count;

  TrendModel({required this.id, required this.hashtag, required this.count});
}
