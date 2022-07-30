part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object?> get props => [];
}

class MovieWatchlistEmpty extends MovieWatchlistState {}

class MovieWatchlistHasMessage extends MovieWatchlistState {
  final bool? isAdded;
  final String? message;

  const MovieWatchlistHasMessage(this.isAdded, this.message);

  @override
  List<Object?> get props => [isAdded, message];
}
