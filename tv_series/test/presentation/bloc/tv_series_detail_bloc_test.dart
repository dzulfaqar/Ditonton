import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../../../core/test/dummy_data/dummy_objects.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail])
void main() {
  late TvSeriesDetailBloc tvSeriesDetailBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    tvSeriesDetailBloc = TvSeriesDetailBloc(mockGetTvSeriesDetail);
  });

  test('initial state should be empty', () {
    expect(tvSeriesDetailBloc.state, TvSeriesDetailEmpty());
  });

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    'Should emit [Loading, HasData] when data Detail is gotten successfully',
    build: () {
      when(mockGetTvSeriesDetail.execute(1))
          .thenAnswer((_) async => const Right(testTvSeriesDetail));
      return tvSeriesDetailBloc;
    },
    act: (bloc) => bloc.add(const OnFetchingDetail(1)),
    expect: () => [
      TvSeriesDetailLoading(),
      const TvSeriesDetailHasData(testTvSeriesDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesDetail.execute(1));
    },
  );

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    'Should emit [Loading, Empty] when data Detail is null',
    build: () {
      when(mockGetTvSeriesDetail.execute(1))
          .thenAnswer((_) async => const Right(null));
      return tvSeriesDetailBloc;
    },
    act: (bloc) => bloc.add(const OnFetchingDetail(1)),
    expect: () => [
      TvSeriesDetailLoading(),
      TvSeriesDetailEmpty(),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesDetail.execute(1));
    },
  );

  blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
    'Should emit [Loading, Error] when data Detail is unsuccessful',
    build: () {
      when(mockGetTvSeriesDetail.execute(1))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesDetailBloc;
    },
    act: (bloc) => bloc.add(const OnFetchingDetail(1)),
    expect: () => [
      TvSeriesDetailLoading(),
      const TvSeriesDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesDetail.execute(1));
    },
  );
}
