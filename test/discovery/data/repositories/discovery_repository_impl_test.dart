import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yeti_movies/discovery/data/data.dart';

class MockDiscoveryDatasource extends Mock implements DiscoveryDatasource {}

void main() {
  late DiscoveryRepositoryImpl repository;
  late MockDiscoveryDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockDiscoveryDatasource();
    repository = DiscoveryRepositoryImpl(datasource: mockDatasource);
  });

  group('fetchDiscoveryMovies', () {
    test('should return a list of MovieEntity on successful fetch', () async {
      final mockMovies = List.generate(
        3,
        (i) => MovieModel(
          id: i,
          title: 'Inside Out 2',
          overview:
              r'''Teenager Riley's mind headquarters is undergoing a sudden
            demolition to make room for something entirely unexpected: new
            Emotions! Joy, Sadness, Anger, Fear and Disgust, who've long been
            running a successful operation by all accounts, aren't sure how to
            feel when Anxiety shows up. And it looks like she's not alone.''',
          voteAverage: 7.706,
          releaseDate: DateTime(2024, 6, 11),
          posterPath: '/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg',
        ),
      );

      when(() => mockDatasource.fetchDiscoveryMovies())
          .thenAnswer((_) async => mockMovies);

      final result = await repository.fetchDiscoveryMovies();

      expect(result, isA<Right<Failure, List<MovieEntity>>>());
      result.fold((l) {}, (r) {
        expect(r.length, equals(3));
      });
    });

    test('should return a ServerFailure on fetch error', () async {
      final exception = Exception('Fetch error');
      when(() => mockDatasource.fetchDiscoveryMovies()).thenThrow(exception);

      final result = await repository.fetchDiscoveryMovies();

      expect(result, isA<Left<Failure, List<MovieEntity>>>());
    });
  });
}
