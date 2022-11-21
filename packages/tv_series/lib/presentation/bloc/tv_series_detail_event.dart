part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailEvent {
  const TvSeriesDetailEvent();
}

class OnFetchingDetail extends TvSeriesDetailEvent {
  final int id;
  const OnFetchingDetail(this.id);
}
