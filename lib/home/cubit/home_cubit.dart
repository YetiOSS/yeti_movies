import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:tmdb_api/tmdb_api.dart';

part 'movies_state.dart';

class HomeCubit extends Cubit<MoviesState> {
  HomeCubit({
    required MovieRepository movieRepository,
  })  : _movieRepository = movieRepository,
        super(const MoviesState());

  final MovieRepository _movieRepository;

  Future<void> fetchPopularMovies() async {
    emit(
      MoviesState(
        status: MoviesStatus.loading,
        movies: state.movies,
      ),
    );

    try {
      final movies = await _movieRepository.fetchPopularMovies();
      emit(
        MoviesState(
          status: MoviesStatus.success,
          movies: movies,
        ),
      );
    } on Exception {
      emit(
        MoviesState(
          status: MoviesStatus.failure,
          movies: state.movies,
        ),
      );
    }
  }
}
