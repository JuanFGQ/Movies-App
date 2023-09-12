import 'package:dio/dio.dart';
import 'package:flutter_application_1/clean_architecture/features/main/data/data_sources/remote/movie_api_service.dart';
import 'package:flutter_application_1/clean_architecture/features/main/data/repository/movies_api_implementation.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/repositories/movie_repository.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/usecases/get_article.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/bloc/movies_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
// //Dependencies

  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<MoviesApiService>(MoviesApiService(sl()));
  sl.registerSingleton<MovieRepository>(MoviesRepositoryImpl(sl()));
//usecases
  sl.registerSingleton<GetMovieUseCase>(GetMovieUseCase(sl()));

// //BLOCS
  sl.registerFactory<RemoteMoviesBloc>(() => RemoteMoviesBloc(sl()));
}
