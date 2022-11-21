import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetTvSeriesEpisode {
  final MovieRepository repository;

  GetTvSeriesEpisode(this.repository);

  Future<Either<Failure, TvSeriesEpisode?>> execute(int id, int season) {
    return repository.getTvSeriesEpisode(id, season);
  }
}
