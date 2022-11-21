import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecases/get_tv_series_episode.dart';

part 'tv_series_episode_event.dart';
part 'tv_series_episode_state.dart';

class TvSeriesEpisodeBloc
    extends Bloc<TvSeriesEpisodeEvent, TvSeriesEpisodeState> {
  final GetTvSeriesEpisode getTvSeriesEpisode;

  TvSeriesEpisodeBloc(this.getTvSeriesEpisode) : super(TvSeriesEpisodeEmpty()) {
    on<OnFetchingEpisode>((event, emit) async {
      emit(TvSeriesEpisodeLoading());

      final result = await getTvSeriesEpisode.execute(event.id, event.season);

      result.fold(
        (failure) {
          emit(TvSeriesEpisodeError(failure.message));
        },
        (data) {
          emit(TvSeriesEpisodeHasData(data));
        },
      );
    });
  }
}
