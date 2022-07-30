part of 'popular_movies_bloc.dart';

abstract class PopularMoviesEvent {
  const PopularMoviesEvent();
}

class OnFetchingPopular extends PopularMoviesEvent {
  const OnFetchingPopular();
}
