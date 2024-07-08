part of 'discovery_cubit.dart';

/// enum for emition status events
enum DiscoveryMoviesStatus { initial, loading, success, failure }

class DiscoveryMoviesState extends Equatable {
  const DiscoveryMoviesState({
    this.status = DiscoveryMoviesStatus.initial,
    this.movies,
  });

  final DiscoveryMoviesStatus status;
  final List<MovieEntity>? movies;

  @override
  List<Object?> get props => [status, movies];
}
