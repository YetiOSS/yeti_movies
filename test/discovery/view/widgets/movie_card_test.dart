import 'package:flutter/material.dart';
import 'package:flutter_image_test_utils/flutter_image_test_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yeti_movies/discovery/data/data.dart';
import 'package:yeti_movies/discovery/view/widgets/widgets.dart';

void main() {
  group('MovieCard', () {
    final movie = MovieEntity(
      id: 1,
      title: 'Movie Title',
      overview: 'Movie Overview',
      posterPath: '/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg',
      voteAverage: 7.1,
      releaseDate: DateTime(2024, 6, 11),
    );

    testWidgets('renders movie card with correct title and overview',
        (tester) async {
      await provideMockedNetworkImages(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MovieCard(movie: movie),
            ),
          ),
        );
      });

      expect(find.text(movie.title), findsOneWidget);
      expect(find.text(movie.overview), findsNothing);
      expect(find.byType(TmdbImageNetworkWidget), findsOneWidget);
    });

    testWidgets('MovieCard expands and collapses on tap',
        (WidgetTester tester) async {
      await provideMockedNetworkImages(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: MovieCard(movie: movie),
            ),
          ),
        );

        await tester.tap(find.byType(MovieCard));
        await tester.pump();
        expect(find.text(movie.overview), findsOneWidget);

        await tester.tap(find.byType(MovieCard));
        await tester.pump();

        await tester.pump(const Duration(milliseconds: 250));
        await tester.pump(const Duration(milliseconds: 500));

        expect(find.text(movie.overview), findsNothing);
      });
    });
  });
}
