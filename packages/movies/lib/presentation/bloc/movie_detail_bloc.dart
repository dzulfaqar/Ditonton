import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailBloc(this.getMovieDetail) : super(MovieDetailEmpty()) {
    on<OnFetchingDetail>((event, emit) async {
      emit(MovieDetailLoading());

      final detail = await getMovieDetail.execute(event.id);

      detail.fold(
        (failure) {
          emit(MovieDetailError(failure.message));
        },
        (movie) {
          emit(MovieDetailHasData(movie));
        },
      );
    });
  }
}
