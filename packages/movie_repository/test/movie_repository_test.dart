import 'package:mocktail/mocktail.dart';
import 'package:movie_repository/movie_repository.dart';

import 'package:test/test.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MockTmdbApiClient extends Mock implements TmdbApiClient {}

void main() {
  group('MovieRepository', () {
    late TmdbApiClient tmdbApiClient;
    late MovieRepository subject;

    final movies = List.generate(
      3,
      (i) => Movie(
        id: i,
        title: 'Inside Out 2',
        overview: 'Teenager Riley\'s mind headquarters is undergoing a sudden '
            'demolition to make room for something entirely unexpected: new Emotions! '
            'Joy, Sadness, Anger, Fear and Disgust, who’ve long been running a '
            'successful operation by all accounts, aren’t sure how to feel when '
            'Anxiety shows up. And it looks like she’s not alone.',
        voteAverage: 7.706,
        releaseDate: DateTime(2024, 6, 11),
        posterPath: '/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg',
      ),
    );

    setUp(() {
      tmdbApiClient = MockTmdbApiClient();
      when(() => tmdbApiClient.fetchPopularMovies())
          .thenAnswer((_) async => movies);

      subject = MovieRepository(tmdbApiClient: tmdbApiClient);
    });

    test('constructor returns normally', () {
      expect(
        () => MovieRepository(),
        returnsNormally,
      );
    });

    group('.fetchPopularMovies', () {
      test('throws MoviesException when api throws an exception', () async {
        when(() => tmdbApiClient.fetchPopularMovies()).thenThrow(Exception());

        expect(
          () => subject.fetchPopularMovies(),
          throwsA(isA<MoviesException>()),
        );

        verify(() => tmdbApiClient.fetchPopularMovies()).called(1);
      });

      test('makes correct request', () async {
        await subject.fetchPopularMovies();

        verify(() => tmdbApiClient.fetchPopularMovies()).called(1);
      });
    });
  });
}
