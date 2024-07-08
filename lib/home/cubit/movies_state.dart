part of 'home_cubit.dart';

/// enum for emition status events
enum MoviesStatus { initial, loading, success, failure }

class MoviesState extends Equatable {
  const MoviesState({
    this.status = MoviesStatus.initial,
    this.movies,
  });

  final MoviesStatus status;
  final List<Movie>? movies;

  @override
  List<Object?> get props => [status, movies];
}
