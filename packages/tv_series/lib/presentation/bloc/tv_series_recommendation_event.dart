part of 'tv_series_recommendation_bloc.dart';

abstract class TvSeriesRecommendationEvent {
  const TvSeriesRecommendationEvent();
}

class OnFetchingRecommendation extends TvSeriesRecommendationEvent {
  final int id;
  const OnFetchingRecommendation(this.id);
}
