import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yeti_movies/discovery/data/data.dart';
import 'package:yeti_movies/discovery/domain/domain.dart';

class MockDiscoveryRepository extends Mock implements DiscoveryRepository {}

void main() {
  late DiscoveryUseCaseImpl discoveryUseCase;
  late MockDiscoveryRepository repository;
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
    repository = MockDiscoveryRepository();
    discoveryUseCase = DiscoveryUseCaseImpl(repository: repository);
  });

  test('fetchDiscoveryMovies returns Right with movies', () async {
    when(() => repository.fetchDiscoveryMovies())
        .thenAnswer((_) async => Right(movies));

    final result = await discoveryUseCase.fetchDiscoveryMovies();

    expect(result, equals(Right(movies)));

    verify(() => repository.fetchDiscoveryMovies()).called(1);
  });

  test('fetchDiscoveryMovies returns Left with failure', () async {
    final failure = ServerFailure('Server Failure');
    when(() => repository.fetchDiscoveryMovies())
        .thenAnswer((_) async => Left(failure));

    final result = await discoveryUseCase.fetchDiscoveryMovies();

    expect(result, equals(Left(failure)));

    verify(() => repository.fetchDiscoveryMovies()).called(1);
  });
}
