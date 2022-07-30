import 'package:core/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('should be a class of TV Series when call constructor', () async {
    const result = TvSeries(
      id: 1,
      name: 'Night Court',
      posterPath: '/nazkESnCZVpCjZ3WPs265DFjW0V.jpg',
      overview: 'Night Court is an American television',
    );
    expect(result, testTvSeriesWatchlist);
    expect(result, isInstanceOf<TvSeries>());
  });
}
