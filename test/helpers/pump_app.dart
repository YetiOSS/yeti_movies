import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:yeti_movies/app/app.dart';
import 'package:yeti_movies/discovery/data/data.dart';
import 'package:yeti_movies/discovery/domain/domain.dart';
import 'package:yeti_movies/l10n/l10n.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

class MockDiscoveryDatasource extends Mock implements DiscoveryDatasource {}

class MockDiscoveryRepository extends Mock implements DiscoveryRepository {}

class MockDiscoveryUseCase extends Mock implements DiscoveryUseCase {}

class MockDio extends Mock implements Dio {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp() {
    final movieRepository = MovieRepository();
    final datasource = DiscoveryDatasourceImpl(httpClient: MockDio());

    final discoveryRepository = DiscoveryRepositoryImpl(
      datasource: datasource,
    );
    final discoveryUseCase = DiscoveryUseCaseImpl(
      repository: discoveryRepository,
    );
    return pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: App(
          movieRepository: movieRepository,
          datasource: datasource,
          discoveryUseCase: discoveryUseCase,
          discoveryRepository: discoveryRepository,
        ),
      ),
    );
  }

  Future<void> pumpAppWithWidget(Widget widget) {
    final movieRepository = MovieRepository();
    final datasource = DiscoveryDatasourceImpl(httpClient: Dio());

    final discoveryRepository = DiscoveryRepositoryImpl(
      datasource: datasource,
    );
    final discoveryUseCase = DiscoveryUseCaseImpl(
      repository: discoveryRepository,
    );
    return pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: App(
          movieRepository: movieRepository,
          datasource: datasource,
          discoveryUseCase: discoveryUseCase,
          discoveryRepository: discoveryRepository,
        ),
      ),
    );
  }
}
