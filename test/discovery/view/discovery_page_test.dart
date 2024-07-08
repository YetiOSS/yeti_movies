import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yeti_movies/discovery/discovery.dart';

import '../../helpers/helpers.dart';

class MockDiscoveryCubit extends MockCubit<DiscoveryMoviesState>
    implements DiscoveryCubit {}

void main() {
  group('HomeView', () {
    late DiscoveryCubit discoveryCubit;

    setUp(() {
      discoveryCubit = MockDiscoveryCubit();
    });

    testWidgets('renders current home', (tester) async {
      const state = DiscoveryMoviesState();
      when(() => discoveryCubit.state).thenReturn(state);
      await tester.pumpAppWithWidget(
        BlocProvider.value(
          value: discoveryCubit,
          child: const DiscoveryView(),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(LayoutBuilder), findsOneWidget);
    });
  });
}
