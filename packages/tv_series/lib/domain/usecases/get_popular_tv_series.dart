import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetPopularTvSeries {
  final MovieRepository repository;

  GetPopularTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getPopularTvSeries();
  }
}
