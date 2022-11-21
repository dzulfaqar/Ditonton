import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/watchlist.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistData _getWatchlistData;

  WatchlistBloc(this._getWatchlistData) : super(WatchlistEmpty()) {
    on<OnFetchingData>((event, emit) async {
      emit(WatchlistLoading());

      final result = await _getWatchlistData.execute();
      result.fold(
        (failure) {
          emit(WatchlistError(failure.message));
        },
        (data) {
          emit(WatchlistHasData(data));
        },
      );
    });
  }
}
