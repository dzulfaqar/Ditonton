import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetAiringTodayTvSeries {
  final MovieRepository repository;

  GetAiringTodayTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getAiringTodayTvSeries();
  }
}
