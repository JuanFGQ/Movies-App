import 'package:equatable/equatable.dart';

import '../../data/models/movie_model.dart';

class SearchEntity extends Equatable {
  final int? page;
  final List<MovieModel>? results;
  final int? totalPages;
  final int? totalResults;

  const SearchEntity({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  @override
  List<Object?> get props {
    return [
      page,
      results,
      totalPages,
      totalResults,
    ];
  }
}
