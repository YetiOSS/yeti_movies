import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  const MovieEntity({
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

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        voteAverage,
        releaseDate,
        posterPath,
      ];

  @override
  String toString() => 'MovieEntity($id, $title)';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'vote_average': voteAverage,
      'release_date': releaseDate?.toIso8601String(),
      'poster_path': posterPath,
    };
  }
}
