import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yeti_movies/discovery/data/data.dart';

class MockHttpClient extends Mock implements Dio {}

class MockDatasource extends Mock implements DiscoveryDatasourceImpl {}

void main() {
  late DiscoveryDatasourceImpl datasource;
  late MockHttpClient httpClient;

  setUp(() {
    httpClient = MockHttpClient();
    datasource = DiscoveryDatasourceImpl(httpClient: httpClient);
  });

  group('fetchDiscoveryMovies', () {
    final mockMovies = List.generate(
      3,
      (i) => MovieEntity(
        id: i,
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
    );

    final mockResponse = {
      'results': mockMovies.map((movie) => movie.toJson()).toList(),
    };

    test('returns a list of MovieModel on success', () async {
      when(() => httpClient.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          )).thenAnswer(
        (_) async => Response(
          data: mockResponse,
          requestOptions: RequestOptions(),
          statusCode: 200,
        ),
      );
      final result = await datasource.fetchDiscoveryMovies();

      verify(() => httpClient.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          )).called(1);

      expect(result.length, equals(3));
      expect(result[0].id, equals(0));
      expect(result[0].title, equals('Inside Out 2'));
      expect(
        result[0].overview,
        equals(result.elementAt(0).overview),
      );
      expect(result[0].voteAverage, equals(7.706));
      expect(result[0].releaseDate, equals(DateTime.parse('2024-06-11')));
      expect(
        result[0].posterPath,
        equals('/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg'),
      );
    });
  });
}
