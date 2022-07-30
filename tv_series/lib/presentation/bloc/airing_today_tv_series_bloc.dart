import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

part 'airing_today_tv_series_event.dart';
part 'airing_today_tv_series_state.dart';

class AiringTodayTvSeriesBloc
    extends Bloc<AiringTodayTvSeriesEvent, AiringTodayTvSeriesState> {
  final GetAiringTodayTvSeries getAiringTodayTvSeries;

  AiringTodayTvSeriesBloc(this.getAiringTodayTvSeries)
      : super(AiringTodayTvSeriesEmpty()) {
    on<OnFetchingAiringToday>((event, emit) async {
      emit(AiringTodayTvSeriesLoading());

      final result = await getAiringTodayTvSeries.execute();

      result.fold(
        (failure) {
          emit(AiringTodayTvSeriesError(failure.message));
        },
        (data) {
          emit(AiringTodayTvSeriesHasData(data));
        },
      );
    });
  }
}
