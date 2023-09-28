import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/popular_entity.dart';

import '../../../../domain/entities/movie_entity.dart';

class PopularMoviesState extends Equatable {
  final List<MovieEntity>? popularMovies;

  final Exception? error;

  const PopularMoviesState({this.popularMovies, this.error});

  @override
  List<Object?> get props => [popularMovies, error];
}

class PopularMoviesLoading extends PopularMoviesState {
  const PopularMoviesLoading();
}

class PopularMoviesDone extends PopularMoviesState {
  const PopularMoviesDone(List<MovieEntity> popularMovies)
      : super(popularMovies: popularMovies);
}

class PopularMoviesError extends PopularMoviesState {
  const PopularMoviesError(Exception error) : super(error: error);
}
