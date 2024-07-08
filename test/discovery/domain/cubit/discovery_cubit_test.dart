import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yeti_movies/discovery/data/data.dart';
import 'package:yeti_movies/discovery/domain/domain.dart';

class MockDiscoveryUseCase extends Mock implements DiscoveryUseCase {}

void main() {
  group('DiscoveryCubit', () {
    late DiscoveryCubit discoveryCubit;
    late DiscoveryUseCase discoveryUseCase;
    final movies = [
      MovieEntity(
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
      MovieEntity(
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
      discoveryUseCase = MockDiscoveryUseCase();
      discoveryCubit = DiscoveryCubit(discoveryUseCase: discoveryUseCase);
    });

    tearDown(() {
      discoveryCubit.close();
    });

    test('initial state is initial', () {
      expect(
        DiscoveryCubit(discoveryUseCase: discoveryUseCase).state,
        equals(
          const DiscoveryMoviesState(status: DiscoveryMoviesStatus.initial),
        ),
      );
    });

    test('initial state is correct', () {
      expect(discoveryCubit.state, const DiscoveryMoviesState());
    });

    test('fetchPopularMovies emits loading and success states', () async {
      when(() => discoveryUseCase.fetchDiscoveryMovies())
          .thenAnswer((_) async => Right(movies));

      final expectedStates = [
        const DiscoveryMoviesState(status: DiscoveryMoviesStatus.loading),
        DiscoveryMoviesState(
          status: DiscoveryMoviesStatus.success,
          movies: movies,
        ),
      ];

      expectLater(discoveryCubit.stream, emitsInOrder(expectedStates));

      await discoveryCubit.fetchDiscoveryMovies();

      verify(() => discoveryUseCase.fetchDiscoveryMovies()).called(1);
    });

    test('fetchPopularMovies emits loading and failure states on exception',
        () async {
      when(() => discoveryUseCase.fetchDiscoveryMovies())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      final expectedStates = [
        const DiscoveryMoviesState(status: DiscoveryMoviesStatus.loading),
        const DiscoveryMoviesState(status: DiscoveryMoviesStatus.failure),
      ];

      expectLater(discoveryCubit.stream, emitsInOrder(expectedStates));

      await discoveryCubit.fetchDiscoveryMovies();

      verify(() => discoveryUseCase.fetchDiscoveryMovies()).called(1);
    });

    blocTest<DiscoveryCubit, DiscoveryMoviesState>(
      'emits [loading and success] when fetch is called',
      build: () {
        when(() => discoveryUseCase.fetchDiscoveryMovies()).thenAnswer(
          (_) async => Right(movies),
        );
        return DiscoveryCubit(discoveryUseCase: discoveryUseCase);
      },
      act: (cubit) => cubit.fetchDiscoveryMovies(),
      expect: () => [
        const DiscoveryMoviesState(
          status: DiscoveryMoviesStatus.loading,
        ),
        DiscoveryMoviesState(
          status: DiscoveryMoviesStatus.success,
          movies: movies,
        ),
      ],
    );
    blocTest<DiscoveryCubit, DiscoveryMoviesState>(
      'emits [loading and fail] when fetch is called',
      build: () {
        when(() => discoveryUseCase.fetchDiscoveryMovies()).thenAnswer(
          (_) async => Left(ServerFailure('Server Failure')),
        );
        return DiscoveryCubit(discoveryUseCase: discoveryUseCase);
      },
      act: (cubit) => cubit.fetchDiscoveryMovies(),
      expect: () => [
        const DiscoveryMoviesState(
          status: DiscoveryMoviesStatus.loading,
        ),
        const DiscoveryMoviesState(
          status: DiscoveryMoviesStatus.failure,
        ),
      ],
    );
  });
}
