import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/clean_architecture/features/main/data/models/movie_model.dart';
import 'package:flutter_application_1/clean_architecture/features/main/data/models/now_playing_model.dart';

class NowPlayingEntity extends Equatable {
  final Dates? dates;
  final int? page;
  final List<MovieModel>? results;
  final int? totalPages;
  final int? totalResults;

  const NowPlayingEntity({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  @override
  List<Object?> get props => [
        dates,
        page,
        results,
        totalPages,
        totalResults,
      ];
}

class DatesEntity extends Equatable {
  final DateTime? maximum;
  final DateTime? minimum;

  const DatesEntity({
    this.maximum,
    this.minimum,
  });
  @override
  List<Object?> get props => [
        maximum,
        minimum,
      ];
}
