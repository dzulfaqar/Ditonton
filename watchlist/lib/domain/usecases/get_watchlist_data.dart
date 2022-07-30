import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetWatchlistData {
  final MovieRepository _repository;

  GetWatchlistData(this._repository);

  Future<Either<Failure, List<Watchlist>>> execute() {
    return _repository.getWatchlistData();
  }
}
