import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/credits_entity.dart';

import 'dart:convert';

class CastModel extends CastEntity {
  const CastModel({
    int? id,
    List<CastEntityDom>? cast,
    List<CastEntityDom>? crew,
  }) : super(
          id: id,
          cast: cast,
          crew: crew,
        );

  factory CastModel.fromJson(String str) => CastModel.fromMap(json.decode(str));

  factory CastModel.fromMap(Map<String, dynamic> json) => CastModel(
        id: json["id"] ?? "",
        cast: List<CastEntityDom>.from(
            json["cast"].map((x) => CastFeature.fromJson(x))),
        crew: List<CastEntityDom>.from(
            json["crew"].map((x) => CastFeature.fromJson(x))),
      );

  factory CastModel.fromEntity(CastEntity entity) {
    return CastModel(id: entity.id, cast: entity.cast, crew: entity.crew);
  }
}

class CastFeature extends CastEntityDom {
  const CastFeature({
    bool? adult,
    int? gender,
    int? id,
    String? name,
    String? originalName,
    double? popularity,
    String? profilePath,
    int? castId,
    String? character,
    String? creditId,
    int? order,
    String? department,
    String? job,
  }) : super(
            adult: adult,
            gender: gender,
            id: id,
            name: name,
            popularity: popularity,
            profilePath: profilePath,
            originalName: originalName,
            castId: castId,
            character: character,
            creditId: creditId,
            order: order,
            department: department,
            job: job);

  @override
  get fullProfilePath {
    if (profilePath != null) {
      return 'https://image.tmdb.org/t/p/w500${this.profilePath}';
    }

    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  factory CastFeature.fromJson(Map<String, dynamic> json) => CastFeature(
        adult: json["adult"] ?? "",
        gender: json["gender"] ?? "",
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        originalName: json["original_name"] ?? "",
        popularity: json["popularity"].toDouble() ?? "",
        profilePath:
            json["profile_path"] == null ? null : json["profile_path"] ?? "",
        castId: json["cast_id"] == null ? null : json["cast_id"] ?? "",
        character: json["character"] == null ? null : json["character"] ?? "",
        creditId: json["credit_id"] ?? "",
        order: json["order"] == null ? null : json["order"] ?? "",
        department:
            json["department"] == null ? null : json["department"] ?? "",
        job: json["job"] == null ? null : json["job"] ?? "",
      );

  factory CastFeature.fromEntity(CastEntityDom entity) {
    return CastFeature(
      adult: entity.adult,
      gender: entity.gender,
      id: entity.id,
      name: entity.name,
      popularity: entity.popularity,
      profilePath: entity.profilePath,
      originalName: entity.originalName,
      castId: entity.castId,
      character: entity.character,
      creditId: entity.creditId,
      order: entity.order,
      department: entity.department,
      job: entity.job,
    );
  }
}

















// class CastModel extends CastEntity {
//   const CastModel({
// // bool? adult;
//     int? gender,
//     int? id,
//     String? name,
//     String? originalName,
//     double? popularity,
//     String? profilePath,
//     int? castId,
//     String? character,
//     String? creditId,
//     int? order,
//     String? department,
//     String? job,
//   }) : super(
//             gender: gender,
//             id: id,
//             name: name,
//             originalName: originalName,
//             popularity: popularity,
//             profilePath: profilePath,
//             castId: castId,
//             character: character,
//             creditId: creditId,
//             order: order,
//             department: department,
//             job: job);

//   factory CastModel.fromJson(Map<String, dynamic> json) {
//     return CastModel(
//       gender: json["gender"] ?? "",
//       id: json["id"] ?? "",
//       name: json["name"] ?? "",
//       originalName: json["originalName"] ?? "",
//       popularity: json["popularity"].toDouble() ?? "",
//       profilePath: json["profilePath"] ?? "",
//       castId: json["castId"] ?? "",
//       character: json["character"] ?? "",
//       creditId: json["creditId"] ?? "",
//       order: json["order"] ?? "",
//       department: json["department"] ?? "",
//       job: json["job"] ?? "",
//     );
//   }

//   factory CastModel.fromEntity(CastEntity credits) {
//     return CastModel(
//       gender: credits.gender,
//       id: credits.id,
//       name: credits.name,
//       originalName: credits.originalName,
//       popularity: credits.popularity,
//       profilePath: credits.profilePath,
//       castId: credits.castId,
//       character: credits.character,
//       creditId: credits.creditId,
//       order: credits.order,
//       department: credits.department,
//       job: credits.job,
//     );
//   }
// }
