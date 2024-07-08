import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yeti_movies/discovery/data/data.dart';

import '../domain.dart';

part 'movies_state.dart';

class DiscoveryCubit extends Cubit<DiscoveryMoviesState> {
  DiscoveryCubit({
    required DiscoveryUseCase discoveryUseCase,
  })  : _discoveryUseCase = discoveryUseCase,
        super(const DiscoveryMoviesState());

  final DiscoveryUseCase _discoveryUseCase;

  Future<void> fetchDiscoveryMovies() async {
    emit(
      DiscoveryMoviesState(
        status: DiscoveryMoviesStatus.loading,
        movies: state.movies,
      ),
    );

    final movies = await _discoveryUseCase.fetchDiscoveryMovies();

    movies.fold(
      (failure) => emit(
        DiscoveryMoviesState(
          status: DiscoveryMoviesStatus.failure,
          movies: state.movies,
        ),
      ),
      (movies) => emit(
        DiscoveryMoviesState(
          status: DiscoveryMoviesStatus.success,
          movies: movies,
        ),
      ),
    );
  }
}
