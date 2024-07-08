import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:yeti_movies/l10n/l10n.dart';

import '../../discovery/discovery.dart';
import '../cubit/home_cubit.dart';
import 'widgets/movie_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(
        movieRepository: context.read<MovieRepository>(),
      )..fetchPopularMovies(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final state = context.select((HomeCubit cubit) => cubit.state);
    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceTint,
      appBar: AppBar(title: Text(l10n.appBarTitle)),
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: [
            const Icon(Icons.movie_filter_outlined),
            const SizedBox(width: 4.0),
            Text(l10n.appBarTitleDicovery),
          ],
        ),
        onPressed: () {
          Navigator.of(context).push(DiscoveryPage.route());
        },
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (state.status == MoviesStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == MoviesStatus.failure) {
            return Center(
              child: Text(
                l10n.errorLoadingMovies,
                style: theme.textTheme.displayLarge,
              ),
            );
          }

          return ListView.builder(
            itemCount: state.movies!.length,
            itemBuilder: (context, index) {
              final movie = state.movies![index];
              return MovieCard(movie: movie);
            },
          );
        },
      ),
    );
  }
}
