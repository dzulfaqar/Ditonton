part of 'tv_series_watchlist_bloc.dart';

abstract class TvSeriesWatchlistState extends Equatable {
  const TvSeriesWatchlistState();

  @override
  List<Object?> get props => [];
}

class TvSeriesWatchlistEmpty extends TvSeriesWatchlistState {}

class TvSeriesWatchlistHasMessage extends TvSeriesWatchlistState {
  final bool? isAdded;
  final String? message;

  const TvSeriesWatchlistHasMessage(this.isAdded, this.message);

  @override
  List<Object?> get props => [isAdded, message];
}
