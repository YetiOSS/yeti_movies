import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:yeti_movies/home/home.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  group('HomeCubit', () {
    late HomeCubit homeCubit;
    late MovieRepository movieRepository;
    final movies = [
      Movie(
        id: 1,
        title: 'Inside Out 2',
        overview: r'''Teenager Riley's mind headquarters is undergoing a sudden
            demolition to make room for something entirely unexpected: new
            Emotions! Joy, Sadness, Anger, Fear and Disgust, who've long been
            running a successful operation by all accounts, aren't sure how to
            feel when Anxiety shows up. And it looks like she's not alone.''',
        voteAverage: 7.706,
        releaseDate: DateTime(2024, 6, 11),
        posterPath: '/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg',
      ),
      Movie(
        id: 2,
        title: 'Inside Out 2',
        overview: r'''Teenager Riley's mind headquarters is undergoing a sudden
            demolition to make room for something entirely unexpected: new
            Emotions! Joy, Sadness, Anger, Fear and Disgust, who've long been
            running a successful operation by all accounts, aren't sure how to
            feel when Anxiety shows up. And it looks like she's not alone.''',
        voteAverage: 7.706,
        releaseDate: DateTime(2024, 6, 11),
        posterPath: '/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg',
      )
    ];

    setUp(() {
      movieRepository = MockMovieRepository();
      homeCubit = HomeCubit(movieRepository: movieRepository);
    });

    tearDown(() {
      homeCubit.close();
    });

    test('initial state is initial', () {
      expect(
        HomeCubit(movieRepository: movieRepository).state,
        equals(const MoviesState(status: MoviesStatus.initial)),
      );
    });

    test('initial state is correct', () {
      expect(homeCubit.state, const MoviesState());
    });

    test('fetchPopularMovies emits loading and success states', () async {
      when(() => movieRepository.fetchPopularMovies())
          .thenAnswer((_) async => movies);

      final expectedStates = [
        const MoviesState(status: MoviesStatus.loading),
        MoviesState(status: MoviesStatus.success, movies: movies),
      ];

      expectLater(homeCubit.stream, emitsInOrder(expectedStates));

      await homeCubit.fetchPopularMovies();

      verify(() => movieRepository.fetchPopularMovies()).called(1);
    });

    test('fetchPopularMovies emits loading and failure states on exception',
        () async {
      when(() => movieRepository.fetchPopularMovies()).thenThrow(Exception());

      final expectedStates = [
        const MoviesState(status: MoviesStatus.loading),
        const MoviesState(status: MoviesStatus.failure),
      ];

      expectLater(homeCubit.stream, emitsInOrder(expectedStates));

      await homeCubit.fetchPopularMovies();

      verify(() => movieRepository.fetchPopularMovies()).called(1);
    });

    blocTest<HomeCubit, MoviesState>(
      'emits [loading and success] when fetch is called',
      build: () {
        when(() => movieRepository.fetchPopularMovies()).thenAnswer(
          (_) async => movies,
        );
        return HomeCubit(movieRepository: movieRepository);
      },
      act: (cubit) => cubit.fetchPopularMovies(),
      expect: () => [
        const MoviesState(status: MoviesStatus.loading),
        MoviesState(status: MoviesStatus.success, movies: movies),
      ],
    );
  });
}
