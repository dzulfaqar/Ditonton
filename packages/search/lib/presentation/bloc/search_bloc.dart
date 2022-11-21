import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/search.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;
  final SearchTvSeries _searchTvSeries;

  SearchBloc(this._searchMovies, this._searchTvSeries) : super(SearchEmpty()) {
    on<OnQueryChangedMovie>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchMovies.execute(query);

      result.fold(
        (failure) {
          emit(SearchError(failure.message));
        },
        (data) {
          emit(SearchHasDataMovie(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));

    on<OnQueryChangedTvSeries>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchTvSeries.execute(query);

      result.fold(
        (failure) {
          emit(SearchError(failure.message));
        },
        (data) {
          emit(SearchHasDataTvSeries(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
