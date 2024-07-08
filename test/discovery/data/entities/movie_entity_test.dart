import 'package:flutter_test/flutter_test.dart';
import 'package:yeti_movies/discovery/data/entities/movie_entity.dart';

void main() {
  group('MovieEntity', () {
    final movie = MovieEntity(
      id: 1,
      title: 'Movie Title',
      overview: 'Movie Overview',
      voteAverage: 7.1,
      releaseDate: DateTime(2024, 6, 11),
      posterPath: '/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg',
    );

    test('should return correct string representation', () {
      expect(movie.toString(), 'MovieEntity(1, Movie Title)');
    });

    test('should return correct JSON representation', () {
      final json = {
        'id': 1,
        'title': 'Movie Title',
        'overview': 'Movie Overview',
        'vote_average': 7.1,
        'release_date': '2024-06-11T00:00:00.000',
        'poster_path': '/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg',
      };

      expect(movie.toJson(), json);
    });

    test('should have correct equality', () {
      final movie1 = MovieEntity(
        id: 1,
        title: 'Movie Title',
        overview: 'Movie Overview',
        voteAverage: 7.1,
        releaseDate: DateTime(2024, 6, 11),
        posterPath: '/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg',
      );

      final movie2 = MovieEntity(
        id: 1,
        title: 'Movie Title',
        overview: 'Movie Overview',
        voteAverage: 7.1,
        releaseDate: DateTime(2024, 6, 11),
        posterPath: '/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg',
      );

      final movie3 = MovieEntity(
        id: 2,
        title: 'Another Movie',
        overview: 'Another Overview',
        voteAverage: 8.5,
        releaseDate: DateTime(2022, 3, 15),
        posterPath: '/abc123.jpg',
      );

      expect(movie1, equals(movie2));
      expect(movie1, isNot(equals(movie3)));
    });
  });
}
