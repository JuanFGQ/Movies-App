import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/movie_entity.dart';

abstract class PopularMoviesEvent {
  // final List<MovieEntity>? onGetPopularMovies =;

  // PopularMoviesEvent(this.onGetPopularMovies);
}

class GetPopularMovies extends PopularMoviesEvent {}

class AssgingPopularMovies extends PopularMoviesEvent {}
