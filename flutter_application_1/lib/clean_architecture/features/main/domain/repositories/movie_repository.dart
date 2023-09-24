import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/movie_entity.dart';

import '../entities/credits_entity.dart';
import '../entities/popular_entity.dart';

abstract class MovieRepository {
  Future<DataState<List<MovieEntity>>> getMovieArticles();

  Future<DataState<List<PopularResponseEntity>>> getPopularMovies();

  Future<DataState<List<CastEntityDom>>> getActorCast(int id);

  Future<DataState<List<MovieEntity>>> getSearch(String search);
}
