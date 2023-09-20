import 'package:flutter_application_1/clean_architecture/features/main/data/models/movie_model.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/search_entity.dart';

class SearchMovieModel extends SearchEntity {
  const SearchMovieModel({
    // String? heroId,
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    String? releaseDate,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) : super(
            id: id,
            // heroId: heroId,
            adult: adult,
            backdropPath: backdropPath,
            genreIds: genreIds,
            originalLanguage: originalLanguage,
            originalTitle: originalTitle,
            overview: overview,
            popularity: popularity,
            posterPath: posterPath,
            releaseDate: releaseDate,
            title: title,
            video: video,
            voteAverage: voteAverage,
            voteCount: voteCount);

  factory SearchMovieModel.fromJson(Map<String, dynamic> json) {
    return SearchMovieModel(
      adult: json["adult"] ?? "",
      backdropPath: json["backdrop_path"] ?? "",
      genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
      id: json["id"] ?? "",
      originalLanguage: json["original_language"] ?? "",
      originalTitle: json["original_title"] ?? "",
      overview: json["overview"] ?? "",
      popularity: json["popularity"].toDouble() ?? "",
      posterPath: json["poster_path"] ?? "",
      releaseDate: json["release_date"] ?? "",
      title: json["title"] ?? "",
      video: json["video"] ?? "",
      voteAverage: json["vote_average"].toDouble() ?? "",
      voteCount: json["vote_count"] ?? "",
    );
  }

  factory SearchMovieModel.fromEnitity(SearchMovieModel entity) {
    return SearchMovieModel(
        id: entity.id,
        // heroId: entity.heroId,
        adult: entity.adult,
        backdropPath: entity.backdropPath,
        genreIds: entity.genreIds,
        originalLanguage: entity.originalLanguage,
        originalTitle: entity.originalTitle,
        overview: entity.overview,
        popularity: entity.popularity,
        posterPath: entity.posterPath,
        releaseDate: entity.releaseDate,
        title: entity.title,
        video: entity.video,
        voteAverage: entity.voteAverage,
        voteCount: entity.voteCount);
  }
}
