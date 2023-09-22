import 'dart:convert';

import 'package:flutter_application_1/clean_architecture/features/main/data/models/movie_model.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/popular_entity.dart';

class PopularResponseModel extends PopularResponseEntity {
  const PopularResponseModel({
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

  factory PopularResponseModel.fromJson(String str) =>
      PopularResponseModel.fromMap(json.decode(str));

  factory PopularResponseModel.fromMap(Map<String, dynamic> json) =>
      PopularResponseModel(
        page: json["page"],
        results: List<MovieModel>.from(
            json["results"].map((x) => MovieModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  factory PopularResponseModel.fromEntity(PopularResponseEntity entity) {
    return PopularResponseModel(
      page: entity.page,
      //if this not works check this line, maybe the error is here.
      results: entity.results,
      totalPages: entity.totalPages,
      totalResults: entity.totalResults,
    );
  }
}
