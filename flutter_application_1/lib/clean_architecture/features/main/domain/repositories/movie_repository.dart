import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<DataState<List<MovieEntity>>> getMovieArticles();
}
