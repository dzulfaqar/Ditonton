import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetTvSeriesRecommendations {
  final MovieRepository repository;

  GetTvSeriesRecommendations(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(int id) {
    return repository.getTvSeriesRecommendations(id);
  }
}
