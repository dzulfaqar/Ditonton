import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetTopRatedTvSeries {
  final MovieRepository repository;

  GetTopRatedTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTopRatedTvSeries();
  }
}
