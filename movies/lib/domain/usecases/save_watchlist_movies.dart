import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class SaveWatchlistMovies {
  final MovieRepository repository;

  SaveWatchlistMovies(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlistMovies(movie);
  }
}
