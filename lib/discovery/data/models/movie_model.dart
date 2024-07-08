import '../entities/movie_entity.dart';

class MovieModel {
  const MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.voteAverage,
    required this.releaseDate,
    required this.posterPath,
  });

  final int id;
  final String title;
  final String overview;
  final double voteAverage;
  final DateTime? releaseDate;
  final String posterPath;

  factory MovieModel.fromEntity(MovieEntity entity) {
    return MovieModel(
      id: entity.id,
      title: entity.title,
      overview: entity.overview,
      voteAverage: entity.voteAverage,
      releaseDate: entity.releaseDate,
      posterPath: entity.posterPath,
    );
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'],
      title: map['title'],
      overview: map['overview'],
      voteAverage: map['vote_average'],
      releaseDate: DateTime.tryParse(map['release_date']),
      posterPath: map['poster_path'],
    );
  }

  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      title: title,
      overview: overview,
      voteAverage: voteAverage,
      releaseDate: releaseDate,
      posterPath: posterPath,
    );
  }
}
