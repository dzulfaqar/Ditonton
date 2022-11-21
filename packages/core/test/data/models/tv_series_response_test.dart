import 'dart:convert';

import 'package:core/data/models/tv_series_model.dart';
import 'package:core/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  const tvSeriesModel = TvSeriesModel(
    id: 135647,
    name: '2 Good 2 Be True',
    overview:
        'Car mechanic Eloy makes a terrible first impression on Ali, who works for a real estate magnate. But both of them are hiding their true personas.',
    posterPath: '/2Wf5ySCPcnp8lRhbSD7jt0YLz5A.jpg',
  );
  const tvSeriesResponse =
      TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tvSeriesModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series_airing_today.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tvSeriesResponse);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // act
      final result = tvSeriesResponse.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            'id': 135647,
            'name': '2 Good 2 Be True',
            'overview':
                'Car mechanic Eloy makes a terrible first impression on Ali, who works for a real estate magnate. But both of them are hiding their true personas.',
            'poster_path': '/2Wf5ySCPcnp8lRhbSD7jt0YLz5A.jpg',
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
