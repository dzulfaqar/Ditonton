part of 'airing_today_tv_series_bloc.dart';

abstract class AiringTodayTvSeriesEvent {
  const AiringTodayTvSeriesEvent();
}

class OnFetchingAiringToday extends AiringTodayTvSeriesEvent {
  const OnFetchingAiringToday();
}
