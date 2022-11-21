import 'package:core/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('should be a class of Movie when call named constructor', () async {
    const result = Movie.watchlist(
      id: 1,
      overview: 'Overview',
      posterPath: '/path.jpg',
      title: 'Title',
    );
    expect(result, testMovieWatchlist);
    expect(result, isInstanceOf<Movie>());
  });
}
