import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  MovieListBloc(this.getNowPlayingMovies) : super(MovieListEmpty()) {
    on<OnFetchingList>((event, emit) async {
      emit(MovieListLoading());

      final result = await getNowPlayingMovies.execute();
      result.fold(
        (failure) {
          emit(MovieListError(failure.message));
        },
        (moviesData) {
          emit(MovieListHasData(moviesData));
        },
      );
    });
  }
}
