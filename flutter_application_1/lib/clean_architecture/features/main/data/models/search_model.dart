import 'package:flutter_application_1/clean_architecture/features/main/data/models/movie_model.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/search_entity.dart';

class SearchResponse extends SearchEntity {
  const SearchResponse({
    int? page,
    List<MovieModel>? results,
    int? totalPages,
    int? totalResults,
  }) : super(
            page: page,
            results: results,
            totalPages: totalPages,
            totalResults: totalResults);

  factory SearchResponse.fromMap(Map<String, dynamic> json) => SearchResponse(
        page: json["page"] ?? "",
        results: List<MovieModel>.from(
            json["results"].map((x) => MovieModel.fromJson(x))),
        totalPages: json["total_pages"] ?? "",
        totalResults: json["total_results"] ?? "",
      );

  factory SearchResponse.fromEntity(SearchResponse entity) {
    return SearchResponse(
        page: entity.page,
        results: entity.results,
        totalPages: entity.totalPages,
        totalResults: entity.totalResults);
  }
}
