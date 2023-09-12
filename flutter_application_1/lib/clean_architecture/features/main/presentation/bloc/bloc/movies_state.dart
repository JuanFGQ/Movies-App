import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/movie_entity.dart';

abstract class RemoteMoviesState extends Equatable {
  final List<MovieEntity>? movies;

  final Exception? error;

//crear instancia del modelo de las noticias

  const RemoteMoviesState({this.movies, this.error});

  @override
  List<Object> get props => [movies!, error!];
}

class RemoteMoviesLoading extends RemoteMoviesState {
  const RemoteMoviesLoading();
}

class RemoteMoviesDone extends RemoteMoviesState {
  const RemoteMoviesDone(List<MovieEntity> movie) : super(movies: movie);
}

class RemoteMoviesError extends RemoteMoviesState {
//crear archivo clase abstracta para gestionar errores

  const RemoteMoviesError(Exception error) : super(error: error);
}
