import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_airing_today_tv_series.dart';

import '../../../../core/test/helpers/test_helper.mocks.dart';
import '../../../../core/test/dummy_data/dummy_objects.dart';

void main() {
  late GetAiringTodayTvSeries usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetAiringTodayTvSeries(mockMovieRepository);
  });

  group('GetAiringTodayTvSeries Tests', () {
    test('should get list of tv series from the repository', () async {
      // arrange
      when(mockMovieRepository.getAiringTodayTvSeries())
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(testTvSeriesList));
    });
  });
}
