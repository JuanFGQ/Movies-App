import 'package:flutter_application_1/clean_architecture/features/main/data/models/movie_model.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/search_entity.dart';

class SearchMovieModel extends SearchEntity {
  const SearchMovieModel({
    int? page,
    List<MovieModel>? results,
    int? totalPages,
    int? totalResults,
  }) : super(
            page: page,
            results: results,
            totalPages: totalPages,
            totalResults: totalResults);

  factory SearchMovieModel.fromJson(Map<String, dynamic> json) =>
      SearchMovieModel(
        page: json["page"] ?? "",
        results: List<MovieModel>.from(
            json["results"].map((x) => MovieModel.fromJson(x))),
        totalPages: json["total_pages"] ?? "",
        totalResults: json["total_results"] ?? "",
      );

  factory SearchMovieModel.fromEntity(SearchMovieModel entity) {
    return SearchMovieModel(
        page: entity.page,
        results: entity.results,
        totalPages: entity.totalPages,
        totalResults: entity.totalResults);
  }
}
