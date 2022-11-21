import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

part 'top_rated_tv_series_event.dart';
part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesBloc
    extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvSeriesBloc(this.getTopRatedTvSeries)
      : super(TopRatedTvSeriesEmpty()) {
    on<OnFetchingTopRated>((event, emit) async {
      emit(TopRatedTvSeriesLoading());

      final result = await getTopRatedTvSeries.execute();

      result.fold(
        (failure) {
          emit(TopRatedTvSeriesError(failure.message));
        },
        (data) {
          emit(TopRatedTvSeriesHasData(data));
        },
      );
    });
  }
}
