import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:yeti_movies/l10n/l10n.dart';

import '../../discovery/data/data.dart';
import '../../discovery/domain/domain.dart';
import '../../home/view/home_page.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required DiscoveryDatasource datasource,
    required MovieRepository movieRepository,
    required DiscoveryUseCase discoveryUseCase,
    required DiscoveryRepository discoveryRepository,
  })  : _datasource = datasource,
        _movieRepository = movieRepository,
        _discoveryUseCase = discoveryUseCase,
        _discoveryRepository = discoveryRepository;

  final DiscoveryDatasource _datasource;
  final MovieRepository _movieRepository;
  final DiscoveryUseCase _discoveryUseCase;
  final DiscoveryRepository _discoveryRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _datasource),
        RepositoryProvider.value(value: _movieRepository),
        RepositoryProvider.value(value: _discoveryUseCase),
        RepositoryProvider.value(value: _discoveryRepository),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}
