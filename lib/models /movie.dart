class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String overview;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'] ?? '', // Manejar posibles valores nulos
      overview: json['overview'] ?? '',
    );
  }

  String get posterUrl => 'https://image.tmdb.org/t/p/w500$posterPath';
}
