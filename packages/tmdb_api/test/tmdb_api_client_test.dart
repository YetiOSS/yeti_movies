import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MockHttpClient extends Mock implements Dio {}

void main() {
  late TmdbApiClient tmdbApiClient;
  late MockHttpClient httpClient;

  setUp(() {
    httpClient = MockHttpClient();
    tmdbApiClient = TmdbApiClient(httpClient: httpClient);
  });

  group('TmdbApiClient', () {
    group('.fetchPopularMovies', () {
      final mockPopularMovies = List.generate(
        3,
        (i) => Movie(
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

      final mockResponse = {
        'results': mockPopularMovies.map((movie) => movie.toJson()).toList(),
      };

      test('makes correct request and returns list of popular movies',
          () async {
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

        final movies = await tmdbApiClient.fetchPopularMovies();

        verify(() => httpClient.get(
              any(),
              queryParameters: any(named: 'queryParameters'),
            )).called(1);

        expect(movies.length, equals(3));
        expect(movies[0].id, equals(0));
        expect(movies[0].title, equals('Inside Out 2'));
        expect(
          movies[0].overview,
          equals(mockPopularMovies.elementAt(0).overview),
        );
        expect(movies[0].voteAverage, equals(7.706));
        expect(movies[0].releaseDate, equals(DateTime.parse('2024-06-11')));
        expect(
          movies[0].posterPath,
          equals('/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg'),
        );
      });
    });
  });
}
