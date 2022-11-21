import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../../../core/test/dummy_data/dummy_objects.dart';
import 'airing_today_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetAiringTodayTvSeries])
void main() {
  late AiringTodayTvSeriesBloc airingTodayTvSeriesBloc;
  late MockGetAiringTodayTvSeries mockGetAiringTodayTvSeries;

  setUp(() {
    mockGetAiringTodayTvSeries = MockGetAiringTodayTvSeries();
    airingTodayTvSeriesBloc =
        AiringTodayTvSeriesBloc(mockGetAiringTodayTvSeries);
  });

  test('initial state should be empty', () {
    expect(airingTodayTvSeriesBloc.state, AiringTodayTvSeriesEmpty());
  });

  blocTest<AiringTodayTvSeriesBloc, AiringTodayTvSeriesState>(
    'Should emit [Loading, HasData] when data Airing Today is gotten successfully',
    build: () {
      when(mockGetAiringTodayTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));
      return airingTodayTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const OnFetchingAiringToday()),
    expect: () => [
      AiringTodayTvSeriesLoading(),
      AiringTodayTvSeriesHasData(testTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetAiringTodayTvSeries.execute());
    },
  );

  blocTest<AiringTodayTvSeriesBloc, AiringTodayTvSeriesState>(
    'Should emit [Loading, Error] when data Airing Today is unsuccessful',
    build: () {
      when(mockGetAiringTodayTvSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return airingTodayTvSeriesBloc;
    },
    act: (bloc) => bloc.add(const OnFetchingAiringToday()),
    expect: () => [
      AiringTodayTvSeriesLoading(),
      const AiringTodayTvSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetAiringTodayTvSeries.execute());
    },
  );
}
