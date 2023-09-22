import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/clean_architecture/features/main/data/models/movie_model.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/movie_entity.dart';

class PopularResponseEntity extends Equatable {
  final int? page;
  //i dont know if this works. i need to test it
  final List<MovieModel>? results;
  final int? totalPages;
  final int? totalResults;

  const PopularResponseEntity({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  @override
  List<Object?> get props => [page, results, totalPages, totalResults];
}
