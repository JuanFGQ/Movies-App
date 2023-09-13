// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

import 'package:flutter_application_1/clean_architecture/features/main/data/models/movie_model.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/popular_entity.dart';

class PopularMoviesModel extends PopularEntity {
  const PopularMoviesModel({
    int? page,
    List<MovieModel>? results,
    int? totalPages,
    int? totalResults,
  }) : super(
          page: page,
          results: results,
          totalPages: totalPages,
          totalResults: totalResults,
        );

  factory PopularMoviesModel.fromJson(String str) =>
      PopularMoviesModel.fromMap(json.decode(str));

  factory PopularMoviesModel.fromMap(Map<String, dynamic> json) =>
      PopularMoviesModel(
        page: json["page"] ?? "",
        results: List<MovieModel>.from(
            json["results"].map((x) => MovieModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  factory PopularMoviesModel.fromEntity(PopularEntity entity) {
    return PopularMoviesModel(
        page: entity.page,
        results: entity.results,
        totalPages: entity.totalPages,
        totalResults: entity.totalResults);
  }
}
