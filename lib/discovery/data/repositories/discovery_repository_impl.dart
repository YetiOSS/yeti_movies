import 'package:fpdart/fpdart.dart';

import '../../domain/domain.dart';
import '../data.dart';

class DiscoveryRepositoryImpl implements DiscoveryRepository {
  final DiscoveryDatasource datasource;

  DiscoveryRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<MovieEntity>>> fetchDiscoveryMovies() async {
    try {
      final result = await datasource.fetchDiscoveryMovies();
      final listEntity = result.map((model) => model.toEntity()).toList();
      return Right(listEntity);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
