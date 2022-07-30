part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent {
  const MovieDetailEvent();
}

class OnFetchingDetail extends MovieDetailEvent {
  final int id;
  const OnFetchingDetail(this.id);
}
