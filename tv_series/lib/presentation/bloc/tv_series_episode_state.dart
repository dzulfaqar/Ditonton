part of 'tv_series_episode_bloc.dart';

abstract class TvSeriesEpisodeState extends Equatable {
  const TvSeriesEpisodeState();

  @override
  List<Object?> get props => [];
}

class TvSeriesEpisodeEmpty extends TvSeriesEpisodeState {}

class TvSeriesEpisodeLoading extends TvSeriesEpisodeState {}

class TvSeriesEpisodeError extends TvSeriesEpisodeState {
  final String message;

  const TvSeriesEpisodeError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvSeriesEpisodeHasData extends TvSeriesEpisodeState {
  final TvSeriesEpisode? result;

  const TvSeriesEpisodeHasData(this.result);

  @override
  List<Object?> get props => [result];
}
