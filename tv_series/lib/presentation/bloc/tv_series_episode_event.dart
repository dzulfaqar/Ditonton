part of 'tv_series_episode_bloc.dart';

abstract class TvSeriesEpisodeEvent {
  const TvSeriesEpisodeEvent();
}

class OnFetchingEpisode extends TvSeriesEpisodeEvent {
  final int id;
  final int season;
  const OnFetchingEpisode(this.id, this.season);
}
