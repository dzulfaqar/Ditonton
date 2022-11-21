import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../../../core/test/dummy_data/dummy_objects.dart';
import 'tv_series_episode_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesEpisode])
void main() {
  late TvSeriesEpisodeBloc tvSeriesEpisodeBloc;
  late MockGetTvSeriesEpisode mockGetTvSeriesEpisode;

  setUp(() {
    mockGetTvSeriesEpisode = MockGetTvSeriesEpisode();
    tvSeriesEpisodeBloc = TvSeriesEpisodeBloc(mockGetTvSeriesEpisode);
  });

  test('initial state should be empty', () {
    expect(tvSeriesEpisodeBloc.state, TvSeriesEpisodeEmpty());
  });

  blocTest<TvSeriesEpisodeBloc, TvSeriesEpisodeState>(
    'Should emit [Loading, HasData] when data Episode is gotten successfully',
    build: () {
      when(mockGetTvSeriesEpisode.execute(1, 1))
          .thenAnswer((_) async => const Right(testTvSeriesEpisode));
      return tvSeriesEpisodeBloc;
    },
    act: (bloc) => bloc.add(const OnFetchingEpisode(1, 1)),
    expect: () => [
      TvSeriesEpisodeLoading(),
      const TvSeriesEpisodeHasData(testTvSeriesEpisode),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesEpisode.execute(1, 1));
    },
  );

  blocTest<TvSeriesEpisodeBloc, TvSeriesEpisodeState>(
    'Should emit [Loading, Error] when data Episode is unsuccessful',
    build: () {
      when(mockGetTvSeriesEpisode.execute(1, 1))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesEpisodeBloc;
    },
    act: (bloc) => bloc.add(const OnFetchingEpisode(1, 1)),
    expect: () => [
      TvSeriesEpisodeLoading(),
      const TvSeriesEpisodeError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesEpisode.execute(1, 1));
    },
  );
}
