import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv_series.dart';

import '../../../../core/test/helpers/test_helper.mocks.dart';
import '../../../../core/test/dummy_data/dummy_objects.dart';

void main() {
  late GetTopRatedTvSeries usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetTopRatedTvSeries(mockMovieRepository);
  });

  group('GetTopRatedTvSeries Tests', () {
    test('should get list of tv series from the repository', () async {
      // arrange
      when(mockMovieRepository.getTopRatedTvSeries())
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(testTvSeriesList));
    });
  });
}
