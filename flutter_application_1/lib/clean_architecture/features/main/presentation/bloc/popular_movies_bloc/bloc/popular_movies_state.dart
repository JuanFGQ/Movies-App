import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/popular_entity.dart';

abstract class PopularMoviesState extends Equatable {
  final List<PopularMovieEntity>? popularMovies;

  final Exception? error;

  const PopularMoviesState({this.popularMovies, this.error});

  @override
  List<Object?> get props => [popularMovies!, error!];
}

class PopularMoviesLoading extends PopularMoviesState {
  const PopularMoviesLoading();
}

class PopularMoviesDone extends PopularMoviesState {
  const PopularMoviesDone(List<PopularMovieEntity> popularMovies)
      : super(popularMovies: popularMovies);
}

class PopularMoviesError extends PopularMoviesState {
  const PopularMoviesError(Exception error) : super(error: error);
}
