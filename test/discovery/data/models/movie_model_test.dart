import 'package:flutter_test/flutter_test.dart';
import 'package:yeti_movies/discovery/data/entities/movie_entity.dart';
import 'package:yeti_movies/discovery/data/models/movie_model.dart';

void main() {
  final movieEntity = MovieEntity(
    id: 1,
    title: 'Movie Title',
    overview: 'Movie Overview',
    voteAverage: 7.1,
    releaseDate: DateTime(2024, 6, 11),
    posterPath: '/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg',
  );

  test('MovieModel.fromEntity should convert MovieEntity to MovieModel', () {
    final movieModel = MovieModel.fromEntity(movieEntity);

    expect(movieModel.id, movieEntity.id);
    expect(movieModel.title, movieEntity.title);
    expect(movieModel.overview, movieEntity.overview);
    expect(movieModel.voteAverage, movieEntity.voteAverage);
    expect(movieModel.releaseDate, movieEntity.releaseDate);
    expect(movieModel.posterPath, movieEntity.posterPath);
  });

  test('MovieModel.fromMap should convert a map to MovieModel', () {
    final movieMap = <String, dynamic>{
      'id': 1,
      'title': 'Movie Title',
      'overview': 'Movie Overview',
      'vote_average': 7.1,
      'release_date': '2024-06-11',
      'poster_path': '/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg',
    };

    final movieModel = MovieModel.fromMap(movieMap);

    expect(movieModel.id, movieMap['id']);
    expect(movieModel.title, movieMap['title']);
    expect(movieModel.overview, movieMap['overview']);
    expect(movieModel.voteAverage, movieMap['vote_average']);
    expect(movieModel.releaseDate, DateTime.tryParse(movieMap['release_date']));
    expect(movieModel.posterPath, movieMap['poster_path']);
  });

  test('MovieModel.toEntity should convert MovieModel to MovieEntity', () {
    final movieModel = MovieModel(
      id: 1,
      title: 'Movie Title',
      overview: 'Movie Overview',
      voteAverage: 7.1,
      releaseDate: DateTime(2024, 6, 11),
      posterPath: '/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg',
    );

    final movieEntity = movieModel.toEntity();

    expect(movieEntity.id, movieModel.id);
    expect(movieEntity.title, movieModel.title);
    expect(movieEntity.overview, movieModel.overview);
    expect(movieEntity.voteAverage, movieModel.voteAverage);
    expect(movieEntity.releaseDate, movieModel.releaseDate);
    expect(movieEntity.posterPath, movieModel.posterPath);
  });
}
