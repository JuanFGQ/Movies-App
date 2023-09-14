import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/usecases/get_article.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/movies_bloc/movies_event.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/movies_bloc/movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteMoviesBloc extends Bloc<RemoteMoviesEvent, RemoteMoviesState> {
  final GetMovieUseCase _getMovieUseCase;
  // final GetMovieCredits _getMovieCredits;

  RemoteMoviesBloc(
    this._getMovieUseCase,
  ) : super((const RemoteMoviesLoading())) {
    on<GetMovies>(onGetMovies);
  }

  void onGetMovies(GetMovies event, Emitter<RemoteMoviesState> emit) async {
    final dataState = await _getMovieUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteMoviesDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteMoviesError(state.error!));
    }
  }
}
