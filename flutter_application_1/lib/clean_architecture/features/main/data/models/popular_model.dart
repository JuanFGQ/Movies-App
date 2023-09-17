import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/popular_entity.dart';

class PopularMovieModel extends PopularMovieEntity {
  const PopularMovieModel({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) : super(
          adult: adult,
          backdropPath: backdropPath,
          genreIds: genreIds,
          id: id,
          originalTitle: originalTitle,
          overview: overview,
          popularity: popularity,
          posterPath: posterPath,
          title: title,
          video: video,
          voteAverage: voteAverage,
          voteCount: voteCount,
        );

  factory PopularMovieModel.fromJson(Map<String, dynamic> json) =>
      PopularMovieModel(
        adult: json["adult"] ?? "",
        backdropPath: json["backdrop_path"] ?? "",
        genreIds: json["genre_ids"] == null
            ? []
            : List<int>.from(json["genre_ids"]!.map((x) => x)),
        id: json["id"] ?? "",
        originalTitle: json["original_title"] ?? "",
        overview: json["overview"] ?? "",
        popularity: json["popularity"]?.toDouble() ?? "",
        posterPath: json["poster_path"] ?? "",
        title: json["title"] ?? "",
        video: json["video"] ?? "",
        voteAverage: json["vote_average"]?.toDouble() ?? "",
        voteCount: json["vote_count"] ?? "",
      );

  factory PopularMovieModel.fromEntity(PopularMovieEntity entity) {
    return PopularMovieModel(
      adult: entity.adult,
      backdropPath: entity.backdropPath,
      genreIds: entity.genreIds,
      id: entity.id,
      originalTitle: entity.originalTitle,
      overview: entity.overview,
      popularity: entity.popularity,
      posterPath: entity.posterPath,
      title: entity.title,
      video: entity.video,
      voteAverage: entity.voteAverage,
      voteCount: entity.voteCount,
    );
  }
}
