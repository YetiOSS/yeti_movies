import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yeti_movies/home/home.dart';

import '../../helpers/helpers.dart';

class MockHomeCubit extends MockCubit<MoviesState> implements HomeCubit {}

void main() {
  group('HomePage', () {
    testWidgets('renders HomeView', (tester) async {
      await tester.pumpApp();
      await tester.pumpAndSettle();
      expect(find.byType(HomeView), findsOneWidget);
    });
  });

  group('HomeView', () {
    late HomeCubit homeCubit;

    setUp(() {
      homeCubit = MockHomeCubit();
    });

    testWidgets('renders current home', (tester) async {
      const state = MoviesState();
      when(() => homeCubit.state).thenReturn(state);
      await tester.pumpAppWithWidget(
        BlocProvider.value(
          value: homeCubit,
          child: const HomeView(),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(LayoutBuilder), findsOneWidget);
    });
  });
}
