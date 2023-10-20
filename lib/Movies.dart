class Movie {
  final int id;
  final String title;
  final double voteAverage;
  final String releaseDate;
  final String overview;
  final String posterPath;

  Movie(this.id, this.title, this.voteAverage, this.releaseDate, this.overview, this.posterPath);

  factory Movie.fromJson(Map<String, dynamic> parsedJson) {
    final id = parsedJson['id'] as int;
    final title = parsedJson['title'] as String;
    final voteAverage = parsedJson['vote_average'] * 1.0 as double;
    final releaseDate = parsedJson['release_date'] as String;
    final overview = parsedJson['overview'] as String;
    final posterPath = parsedJson['poster_path'] as String;
    return Movie(id, title, voteAverage, releaseDate, overview, posterPath);
  }
}

class MovieCategory {
  final String name;
  final String apiEndpoint;

  MovieCategory(this.name, this.apiEndpoint);
}