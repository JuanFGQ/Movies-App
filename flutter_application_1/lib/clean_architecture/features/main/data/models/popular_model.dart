// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

import 'package:flutter_application_1/clean_architecture/features/main/data/models/movie_model.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/popular_entity.dart';

class PopularResponse extends PopularEntity {
  const PopularResponse({
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

  factory PopularResponse.fromJson(String str) =>
      PopularResponse.fromMap(json.decode(str));

  factory PopularResponse.fromMap(Map<String, dynamic> json) => PopularResponse(
        page: json["page"] ?? "",
        results: List<MovieModel>.from(
            json["results"].map((x) => MovieModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  factory PopularResponse.fromEntity(PopularEntity entity) {
    return PopularResponse(
        page: entity.page,
        results: entity.results,
        totalPages: entity.totalPages,
        totalResults: entity.totalResults);
  }
}
