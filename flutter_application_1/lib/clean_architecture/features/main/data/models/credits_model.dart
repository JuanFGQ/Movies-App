import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/credits_entity.dart';

class CastModel extends CastEntity {
  const CastModel({
// bool? adult;
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
            gender: gender,
            id: id,
            name: name,
            originalName: originalName,
            popularity: popularity,
            profilePath: profilePath,
            castId: castId,
            character: character,
            creditId: creditId,
            order: order,
            department: department,
            job: job);

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      gender: json["gender"] ?? "",
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      originalName: json["originalName"] ?? "",
      popularity: json["popularity"].toDouble() ?? "",
      profilePath: json["profilePath"] ?? "",
      castId: json["castId"] ?? "",
      character: json["character"] ?? "",
      creditId: json["creditId"] ?? "",
      order: json["order"] ?? "",
      department: json["department"] ?? "",
      job: json["job"] ?? "",
    );
  }

  factory CastModel.fromEntity(CastEntity credits) {
    return CastModel(
      gender: credits.gender,
      id: credits.id,
      name: credits.name,
      originalName: credits.originalName,
      popularity: credits.popularity,
      profilePath: credits.profilePath,
      castId: credits.castId,
      character: credits.character,
      creditId: credits.creditId,
      order: credits.order,
      department: credits.department,
      job: credits.job,
    );
  }
}
