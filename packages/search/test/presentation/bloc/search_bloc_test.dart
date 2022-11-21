import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv_series.dart';
import 'package:search/presentation/bloc/search_bloc.dart';

import '../../../../core/test/dummy_data/dummy_objects.dart';
import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchTvSeries])
void main() {
  late SearchBloc searchBloc;
  late MockSearchMovies mockSearchMovies;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockSearchTvSeries = MockSearchTvSeries();
    searchBloc = SearchBloc(mockSearchMovies, mockSearchTvSeries);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchEmpty());
  });

  blocTest<SearchBloc, SearchState>(
    'Should emit [Loading, HasData] when data movie is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(testMovieQuery))
          .thenAnswer((_) async => Right(tMovieList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedMovie(testMovieQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchHasDataMovie(tMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(testMovieQuery));
    },
  );

  blocTest<SearchBloc, SearchState>(
    'Should emit [Loading, Error] when get search movie is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(testMovieQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedMovie(testMovieQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      const SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(testMovieQuery));
    },
  );

  blocTest<SearchBloc, SearchState>(
    'Should emit [Loading, HasData] when data tv series is gotten successfully',
    build: () {
      when(mockSearchTvSeries.execute(testTvSeriesQuery))
          .thenAnswer((_) async => Right(testTvSeriesList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedTvSeries(testTvSeriesQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchHasDataTvSeries(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(testTvSeriesQuery));
    },
  );

  blocTest<SearchBloc, SearchState>(
    'Should emit [Loading, Error] when get search tv series is unsuccessful',
    build: () {
      when(mockSearchTvSeries.execute(testTvSeriesQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChangedTvSeries(testTvSeriesQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      const SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(testTvSeriesQuery));
    },
  );
}
