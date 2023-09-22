import 'package:equatable/equatable.dart';

class CastEntity extends Equatable {
  final int? id;
  final List<CastEntityDom>? cast;
  final List<CastEntityDom>? crew;

  const CastEntity({
    this.id,
    this.cast,
    this.crew,
  });

  @override
  List<Object?> get props => [id, cast, crew];
}

class CastEntityDom extends Equatable {
  const CastEntityDom({
    this.adult,
    this.gender,
    this.id,
    this.name,
    this.popularity,
    this.profilePath,
    this.originalName,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  final bool? adult;
  final int? gender;
  final int? id;
  final String? name;
  final String? originalName;
  final double? popularity;
  final String? profilePath;
  final int? castId;
  final String? character;
  final String? creditId;
  final int? order;
  final String? department;
  final String? job;

  @override
  List<Object?> get props => [
        adult,
        gender,
        id,
        name,
        popularity,
        profilePath,
        castId,
        character,
        creditId,
        order,
        department,
        job,
      ];
}
