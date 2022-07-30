part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent {
  const MovieWatchlistEvent();
}

class OnLoadingWatchlist extends MovieWatchlistEvent {
  final int id;
  const OnLoadingWatchlist(this.id);
}

class OnAddingWatchlist extends MovieWatchlistEvent {
  final MovieDetail movie;
  const OnAddingWatchlist(this.movie);
}

class OnRemovingWatchlist extends MovieWatchlistEvent {
  final MovieDetail movie;
  const OnRemovingWatchlist(this.movie);
}
