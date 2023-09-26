import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/usecases/get_popular_movie.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/popular_movies_bloc/bloc/popular_movies_event.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/popular_movies_bloc/bloc/popular_movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/movie_entity.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMoviesUseCase _getPopularMoviesUserCase;

  PopularMoviesBloc(this._getPopularMoviesUserCase)
      : super((const PopularMoviesLoading())) {
    on<GetPopularMovies>(onGetPopularMovies);
  }

  void onGetPopularMovies(
      GetPopularMovies event, Emitter<PopularMoviesState> emit) async {
    final dataState = await _getPopularMoviesUserCase(params: event.pageNum);

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(PopularMoviesDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(PopularMoviesError(state.error!));
    }
  }
}
