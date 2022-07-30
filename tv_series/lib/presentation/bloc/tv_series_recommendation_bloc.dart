import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

part 'tv_series_recommendation_event.dart';
part 'tv_series_recommendation_state.dart';

class TvSeriesRecommendationBloc
    extends Bloc<TvSeriesRecommendationEvent, TvSeriesRecommendationState> {
  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  TvSeriesRecommendationBloc(this.getTvSeriesRecommendations)
      : super(TvSeriesRecommendationEmpty()) {
    on<OnFetchingRecommendation>((event, emit) async {
      emit(TvSeriesRecommendationLoading());

      final recommendation = await getTvSeriesRecommendations.execute(event.id);

      recommendation.fold(
        (failure) {
          emit(TvSeriesRecommendationError(failure.message));
        },
        (data) {
          emit(TvSeriesRecommendationHasData(data));
        },
      );
    });
  }
}
