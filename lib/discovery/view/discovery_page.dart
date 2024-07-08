import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yeti_movies/l10n/l10n.dart';

import '../domain/domain.dart';
import 'widgets/movie_card.dart';

class DiscoveryPage extends StatelessWidget {
  const DiscoveryPage({super.key});

  static Route<DiscoveryPage> route() {
    return MaterialPageRoute(
      builder: (context) => const DiscoveryPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DiscoveryCubit(
        discoveryUseCase: context.read<DiscoveryUseCase>(),
      )..fetchDiscoveryMovies(),
      child: const DiscoveryView(),
    );
  }
}

class DiscoveryView extends StatelessWidget {
  const DiscoveryView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final state = context.select((DiscoveryCubit cubit) => cubit.state);

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceTint,
      appBar: AppBar(title: Text(l10n.appBarTitleDicovery)),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (state.status == DiscoveryMoviesStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == DiscoveryMoviesStatus.failure) {
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
