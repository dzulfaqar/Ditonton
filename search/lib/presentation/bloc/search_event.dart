part of 'search_bloc.dart';

abstract class SearchEvent {
  const SearchEvent();
}

class OnQueryChangedMovie extends SearchEvent {
  final String query;

  const OnQueryChangedMovie(this.query);
}

class OnQueryChangedTvSeries extends SearchEvent {
  final String query;

  const OnQueryChangedTvSeries(this.query);
}
