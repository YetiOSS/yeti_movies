import 'package:tmdb_api/tmdb_api.dart';

class MoviesException implements Exception {}

class SearchException implements Exception {}

class MovieRepository {
  MovieRepository({TmdbApiClient? tmdbApiClient})
      : _tmdbApiClient = tmdbApiClient ?? TmdbApiClient();

  final TmdbApiClient _tmdbApiClient;

  Future<List<Movie>> fetchPopularMovies() {
    try {
      return _tmdbApiClient.fetchPopularMovies();
    } on Exception {
      throw MoviesException();
    }
  }
}
