import 'package:fpdart/fpdart.dart';

import '../../data/data.dart';
import '../domain.dart';

class DiscoveryUseCaseImpl implements DiscoveryUseCase {
  final DiscoveryRepository repository;

  DiscoveryUseCaseImpl({required this.repository});

  @override
  Future<Either<Failure, List<MovieEntity>>> fetchDiscoveryMovies() async {
    return repository.fetchDiscoveryMovies();
  }
}
