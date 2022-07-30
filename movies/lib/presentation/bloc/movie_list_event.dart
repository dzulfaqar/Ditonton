part of 'movie_list_bloc.dart';

abstract class MovieListEvent {
  const MovieListEvent();
}

class OnFetchingList extends MovieListEvent {
  const OnFetchingList();
}
