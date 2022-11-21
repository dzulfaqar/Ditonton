part of 'top_rated_tv_series_bloc.dart';

abstract class TopRatedTvSeriesEvent {
  const TopRatedTvSeriesEvent();
}

class OnFetchingTopRated extends TopRatedTvSeriesEvent {
  const OnFetchingTopRated();
}
