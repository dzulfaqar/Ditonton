import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;

  TvSeriesDetailBloc(this.getTvSeriesDetail) : super(TvSeriesDetailEmpty()) {
    on<OnFetchingDetail>((event, emit) async {
      emit(TvSeriesDetailLoading());

      final detailResult = await getTvSeriesDetail.execute(event.id);

      detailResult.fold(
        (failure) {
          emit(TvSeriesDetailError(failure.message));
        },
        (data) {
          if (data != null) {
            emit(TvSeriesDetailHasData(data));
          } else {
            emit(TvSeriesDetailEmpty());
          }
        },
      );
    });
  }
}
