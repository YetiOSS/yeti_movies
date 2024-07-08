import 'package:fpdart/fpdart.dart';

import '../../data/data.dart';

abstract class DiscoveryUseCase {
  Future<Either<Failure, List<MovieEntity>>> fetchDiscoveryMovies();
}
