part of 'popular_tv_series_bloc.dart';

abstract class PopularTvSeriesEvent {
  const PopularTvSeriesEvent();
}

class OnFetchingPopular extends PopularTvSeriesEvent {
  const OnFetchingPopular();
}
