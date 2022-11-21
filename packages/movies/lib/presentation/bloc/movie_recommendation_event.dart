part of 'movie_recommendation_bloc.dart';

abstract class MovieRecommendationEvent {
  const MovieRecommendationEvent();
}

class OnFetchingRecommendation extends MovieRecommendationEvent {
  final int id;
  const OnFetchingRecommendation(this.id);
}
