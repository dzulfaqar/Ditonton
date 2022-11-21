import 'package:equatable/equatable.dart';

import 'genre.dart';

class TvSeriesDetail extends Equatable {
  const TvSeriesDetail({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.genres,
    required this.voteAverage,
    required this.episodeRunTime,
    required this.seasons,
  });

  final int id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final List<Genre>? genres;
  final double? voteAverage;
  final List<int>? episodeRunTime;
  final List<Season>? seasons;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      overview,
      posterPath,
      genres,
      voteAverage,
      episodeRunTime,
      seasons,
    ];
  }
}

class Season extends Equatable {
  const Season({
    required this.id,
    required this.name,
    required this.airDate,
    required this.overview,
    required this.posterPath,
    required this.episodeCount,
    required this.seasonNumber,
  });

  final int id;
  final String? name;
  final String? airDate;
  final String? overview;
  final String? posterPath;
  final int? episodeCount;
  final int? seasonNumber;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      airDate,
      overview,
      posterPath,
      episodeCount,
      seasonNumber,
    ];
  }
}
