import 'dart:convert';

import 'package:flutter_application_1/clean_architecture/features/main/data/models/movie_model.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/now_playing_entity.dart';

class NowPlayingMovieModel extends NowPlayingEntity {
  const NowPlayingMovieModel({
    Dates? dates,
    int? page,
    List<MovieModel>? results,
    int? totalPages,
    int? totalResults,
  }) : super(
          dates: dates,
          page: page,
          results: results,
          totalPages: totalPages,
          totalResults: totalResults,
        );

  factory NowPlayingMovieModel.fromJson(String str) =>
      NowPlayingMovieModel.fromMap(json.decode(str));

  factory NowPlayingMovieModel.fromMap(Map<String, dynamic> json) =>
      NowPlayingMovieModel(
        dates: Dates.fromMap(json["dates"]),
        page: json["page"],
        results: List<MovieModel>.from(
            json["results"].map((x) => MovieModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
  factory NowPlayingMovieModel.fromEntity(NowPlayingEntity entity) {
    return NowPlayingMovieModel(
      dates: entity.dates,
      page: entity.page,
      results: entity.results,
      totalPages: entity.totalPages,
      totalResults: entity.totalResults,
    );
  }
}

class Dates extends DatesEntity {
  Dates({
    DateTime? maximum,
    DateTime? minimum,
  }) : super(
          minimum: minimum,
          maximum: maximum,
        );

  factory Dates.fromJson(String str) => Dates.fromMap(json.decode(str));

  factory Dates.fromMap(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );
  factory Dates.fromEntity(DatesEntity entity) {
    return Dates(
      minimum: entity.minimum,
      maximum: entity.maximum,
    );
  }
}
