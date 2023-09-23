import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/clean_architecture/features/main/data/models/movie_model.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/movie_entity.dart';

class SearchEntity extends Equatable {
  final int? page;
  final List<MovieEntity>? results;
  final int? totalPages;
  final int? totalResults;

  const SearchEntity({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  @override
  List<Object?> get props => [
        page,
        results,
        totalPages,
        totalResults,
      ];
}
