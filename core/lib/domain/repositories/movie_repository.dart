import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id);
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id);
  Future<Either<Failure, List<Movie>>> searchMovies(String query);

  Future<Either<Failure, List<TvSeries>>> getAiringTodayTvSeries();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();
  Future<Either<Failure, TvSeriesDetail?>> getTvSeriesDetail(int id);
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendations(int id);
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);
  Future<Either<Failure, TvSeriesEpisode?>> getTvSeriesEpisode(
      int id, int season);

  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Watchlist>>> getWatchlistData();
  Future<Either<Failure, String>> saveWatchlistMovies(MovieDetail movie);
  Future<Either<Failure, String>> removeWatchlistMovies(MovieDetail movie);
  Future<Either<Failure, String>> saveWatchlistTvSeries(
      TvSeriesDetail? tvSeries);
  Future<Either<Failure, String>> removeWatchlistTvSeries(
      TvSeriesDetail? tvSeries);
}
