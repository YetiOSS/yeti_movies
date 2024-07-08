import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:tmdb_api/tmdb_api.dart';

class HttpException implements Exception {}

class HttpRequestFailure implements Exception {
  const HttpRequestFailure(this.statusCode);

  final int? statusCode;
}

class JsonDecodeException implements Exception {}

class JsonDeserializationException implements Exception {}

class TmdbApiClient {
  TmdbApiClient({Dio? httpClient}) : _httpClient = httpClient ?? Dio();

  @visibleForTesting
  static const authority = '76fd28bfde6b70b70e2d22a2d86b65cd';

  @visibleForTesting
  static const identifier = 'https://api.themoviedb.org';

  final Dio _httpClient;

  /// REST call: `GET /movies/popular`
  Future<List<Movie>> fetchPopularMovies() async {
    final responseBody = await _get('$identifier/3/movie/popular');

    try {
      return (responseBody['results'] as List)
          .map((dynamic item) => Movie.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      throw JsonDeserializationException();
    }
  }

  Future<Map<String, dynamic>> _get(String url) async {
    Response response;

    try {
      response = await _httpClient.get(
        url,
        queryParameters: {
          'api_key': authority,
        },
      );
    } catch (_) {
      throw HttpException();
    }

    if (response.statusCode != 200) {
      throw HttpRequestFailure(response.statusCode);
    }

    try {
      return response.data;
    } catch (_) {
      throw JsonDecodeException();
    }
  }
}
