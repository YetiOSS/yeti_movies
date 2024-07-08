import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:yeti_movies/app/app.dart';
import 'package:yeti_movies/discovery/data/data.dart';
import 'package:yeti_movies/discovery/domain/domain.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

class MockDiscoveryDatasource extends Mock implements DiscoveryDatasource {}

class MockDiscoveryRepository extends Mock implements DiscoveryRepository {}

class MockDiscoveryUseCase extends Mock implements DiscoveryUseCase {}

class MockDio extends Mock implements Dio {}

void main() {
  final movieRepository = MovieRepository();
  final datasource = DiscoveryDatasourceImpl(httpClient: MockDio());

  final discoveryRepository = DiscoveryRepositoryImpl(
    datasource: datasource,
  );
  final discoveryUseCase = DiscoveryUseCaseImpl(
    repository: discoveryRepository,
  );
  group('App', () {
    testWidgets('renders HomePage', (tester) async {
      await tester.pumpWidget(
        App(
          movieRepository: movieRepository,
          datasource: datasource,
          discoveryUseCase: discoveryUseCase,
          discoveryRepository: discoveryRepository,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(AppView), findsOneWidget);
    });

    testWidgets('renders AppView with MovieRepository', (tester) async {
      final movieRepository = MovieRepository();
      await tester.pumpWidget(App(
        movieRepository: movieRepository,
        datasource: datasource,
        discoveryUseCase: discoveryUseCase,
        discoveryRepository: discoveryRepository,
      ));
      await tester.pumpAndSettle();

      expect(find.byType(AppView), findsOneWidget);
      expect(
          RepositoryProvider.of<MovieRepository>(
              tester.element(find.byType(AppView))),
          movieRepository);
    });
  });
}
