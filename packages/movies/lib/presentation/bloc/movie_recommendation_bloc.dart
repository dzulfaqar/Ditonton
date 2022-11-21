import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';

part 'movie_recommendation_event.dart';
part 'movie_recommendation_state.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecommendationBloc(this.getMovieRecommendations)
      : super(MovieRecommendationEmpty()) {
    on<OnFetchingRecommendation>((event, emit) async {
      emit(MovieRecommendationLoading());

      final recommendation = await getMovieRecommendations.execute(event.id);

      recommendation.fold(
        (failure) {
          emit(MovieRecommendationError(failure.message));
        },
        (movies) {
          emit(MovieRecommendationHasData(movies));
        },
      );
    });
  }
}
