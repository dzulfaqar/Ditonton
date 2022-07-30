part of 'tv_series_watchlist_bloc.dart';

abstract class TvSeriesWatchlistEvent {
  const TvSeriesWatchlistEvent();
}

class OnLoadingWatchlist extends TvSeriesWatchlistEvent {
  final int id;
  const OnLoadingWatchlist(this.id);
}

class OnAddingWatchlist extends TvSeriesWatchlistEvent {
  final TvSeriesDetail tvSeries;
  const OnAddingWatchlist(this.tvSeries);
}

class OnRemovingWatchlist extends TvSeriesWatchlistEvent {
  final TvSeriesDetail tvSeries;
  const OnRemovingWatchlist(this.tvSeries);
}
