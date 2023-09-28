import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/movie_entity.dart';

abstract class PopularMoviesEvent {}

class GetPopularMovies extends PopularMoviesEvent {
  final int? pageNum;

  GetPopularMovies({this.pageNum = 1});
}

class ConcatenateLists extends PopularMoviesEvent {
  final List<MovieEntity>? concatenatedList;

  ConcatenateLists(this.concatenatedList);
}
