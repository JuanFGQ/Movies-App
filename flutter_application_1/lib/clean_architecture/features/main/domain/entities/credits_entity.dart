import 'package:equatable/equatable.dart';

class CreditsEntity extends Equatable {
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

  const CreditsEntity({
    this.adult,
    this.gender,
    this.id,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  get fullProfilePath {
    if (this.profilePath != null)
      return 'https://image.tmdb.org/t/p/w500${this.profilePath}';

    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  @override
  List<Object?> get props {
    return [
      adult,
      gender,
      id,
      name,
      originalName,
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
}
