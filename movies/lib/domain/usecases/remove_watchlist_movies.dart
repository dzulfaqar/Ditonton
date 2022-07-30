import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class RemoveWatchlistMovies {
  final MovieRepository repository;

  RemoveWatchlistMovies(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlistMovies(movie);
  }
}
