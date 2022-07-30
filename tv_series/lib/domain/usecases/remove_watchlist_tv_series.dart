import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class RemoveWatchlistTvSeries {
  final MovieRepository repository;

  RemoveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail? tvSeriesDetail) {
    return repository.removeWatchlistTvSeries(tvSeriesDetail);
  }
}
