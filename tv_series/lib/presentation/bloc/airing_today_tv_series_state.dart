part of 'airing_today_tv_series_bloc.dart';

abstract class AiringTodayTvSeriesState extends Equatable {
  const AiringTodayTvSeriesState();

  @override
  List<Object> get props => [];
}

class AiringTodayTvSeriesEmpty extends AiringTodayTvSeriesState {}

class AiringTodayTvSeriesLoading extends AiringTodayTvSeriesState {}

class AiringTodayTvSeriesError extends AiringTodayTvSeriesState {
  final String message;

  const AiringTodayTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class AiringTodayTvSeriesHasData extends AiringTodayTvSeriesState {
  final List<TvSeries> result;

  const AiringTodayTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}
