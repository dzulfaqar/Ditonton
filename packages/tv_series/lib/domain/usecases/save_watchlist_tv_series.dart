import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class SaveWatchlistTvSeries {
  final MovieRepository repository;

  SaveWatchlistTvSeries(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail? tvSeries) {
    return repository.saveWatchlistTvSeries(tvSeries);
  }
}
