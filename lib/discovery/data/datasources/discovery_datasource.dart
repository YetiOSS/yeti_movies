import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../data.dart';

abstract class DiscoveryDatasource {
  @visibleForTesting
  static const requestUrl = 'https://api.themoviedb.org/3/discover/movie';

  Future<List<MovieModel>> fetchDiscoveryMovies();
}

class DiscoveryDatasourceImpl implements DiscoveryDatasource {
  final Dio httpClient;

  DiscoveryDatasourceImpl({required this.httpClient});

  @override
  Future<List<MovieModel>> fetchDiscoveryMovies() async {
    try {
      final response = await httpClient.get(
        DiscoveryDatasource.requestUrl,
        queryParameters: {'api_key': '76fd28bfde6b70b70e2d22a2d86b65cd'},
      );

      final data = response.data['results'] as List;
      final movies = data.map((e) => MovieModel.fromMap(e)).toList();
      return movies;
    } on Exception {
      throw Exception(ServerFailure('Failed to fetch movies'));
    }
  }
}
