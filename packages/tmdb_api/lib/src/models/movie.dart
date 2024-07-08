import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class Movie extends Equatable {
  const Movie({
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

  static Movie fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

  @override
  String toString() => 'Movie($id, $title)';
}
