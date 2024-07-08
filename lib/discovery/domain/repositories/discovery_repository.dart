import 'package:fpdart/fpdart.dart';

import '../../data/data.dart';

abstract class DiscoveryRepository {
  Future<Either<Failure, List<MovieEntity>>> fetchDiscoveryMovies();
}
