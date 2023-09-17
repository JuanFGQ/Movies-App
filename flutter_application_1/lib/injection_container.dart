import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/clean_architecture/features/main/data/data_sources/remote/movie_api_service.dart';
import 'package:flutter_application_1/clean_architecture/features/main/data/repository/movies_api_implementation.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/repositories/movie_repository.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/usecases/get_article.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/usecases/get_movie_credits.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/usecases/get_popular_movie.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/usecases/search_movie.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/actors_cast_bloc/bloc/actor_cast_bloc.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/actors_cast_bloc/bloc/actor_cast_event.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/movies_bloc/movies_bloc.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/popular_movies_bloc/bloc/popular_movies_bloc.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/popular_movies_bloc/bloc/popular_movies_event.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/search_movies_bloc/bloc/search_movies_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
// //Dependencies

  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<MoviesApiService>(MoviesApiService(sl()));
  sl.registerSingleton<MovieRepository>(MoviesRepositoryImpl(sl()));
//usecases
  sl.registerSingleton<GetMovieUseCase>(GetMovieUseCase(sl()));
  sl.registerSingleton<GetPopularMoviesUseCase>(GetPopularMoviesUseCase(sl()));
  sl.registerSingleton<GetSearchMovieUseCase>(GetSearchMovieUseCase(sl()));
  // sl.registerSingleton<GetSearchMovieUseCase>(GetSearchMovieUseCase(sl()));

  sl.registerSingleton<GetActorsCastUseCase>(GetActorsCastUseCase(sl()));

// //BLOCS
  sl.registerFactory<RemoteMoviesBloc>(() => RemoteMoviesBloc(sl()));
  sl.registerFactory<PopularMoviesBloc>(() => PopularMoviesBloc(sl()));
  sl.registerFactory<ActorsCastBloc>(() => ActorsCastBloc(sl()));
  sl.registerFactory<SearchMovieBloc>(() => SearchMovieBloc(sl()));
}
