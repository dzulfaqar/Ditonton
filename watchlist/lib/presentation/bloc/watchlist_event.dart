part of 'watchlist_bloc.dart';

abstract class WatchlistEvent {
  const WatchlistEvent();
}

class OnFetchingData extends WatchlistEvent {
  const OnFetchingData();
}
