// ignore_for_file: prefer_const_constructors
import 'package:tmdb_api/tmdb_api.dart';
import 'package:test/test.dart';

void main() {
  group('Movie', () {
    test('supports value comparisons', () {
      expect(
        Movie(
          id: 1,
          title: 'mock-movie-name-1',
          overview: 'mock-movie-overview-1',
          voteAverage: 1.1,
          releaseDate: DateTime(2024, 6, 1),
          posterPath: 'mock-movie-posterPath-1',
        ),
        Movie(
          id: 1,
          title: 'mock-movie-name-1',
          overview: 'mock-movie-overview-1',
          voteAverage: 1.1,
          releaseDate: DateTime(2024, 6, 1),
          posterPath: 'mock-movie-posterPath-1',
        ),
      );
    });

    test('has concise toString', () {
      expect(
        Movie(
          id: 1,
          title: 'mock-movie-name-1',
          overview: 'mock-movie-overview-1',
          voteAverage: 1.1,
          releaseDate: DateTime(2024, 6, 1),
          posterPath: 'mock-movie-posterPath-1',
        ).toString(),
        equals('Movie(1, mock-movie-name-1)'),
      );
    });
  });
}
