import 'package:dio/dio.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:yeti_movies/app/app.dart';
import 'package:yeti_movies/appwrapper.dart';
import 'package:yeti_movies/discovery/data/data.dart';
import 'package:yeti_movies/discovery/domain/domain.dart';

void main() {
  final movieRepository = MovieRepository();
  final datasource = DiscoveryDatasourceImpl(httpClient: Dio());

  final discoveryRepository = DiscoveryRepositoryImpl(
    datasource: datasource,
  );
  final discoveryUseCase = DiscoveryUseCaseImpl(
    repository: discoveryRepository,
  );

  appWrapping(
    () => App(
      movieRepository: movieRepository,
      datasource: datasource,
      discoveryUseCase: discoveryUseCase,
      discoveryRepository: discoveryRepository,
    ),
  );
}
