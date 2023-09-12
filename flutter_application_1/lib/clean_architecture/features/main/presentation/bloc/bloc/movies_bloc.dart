// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// part 'movies_event.dart';
// part 'movies_state.dart';

// class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
//   MoviesBloc() : super(MoviesInitial()) {
//     on<MoviesEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }

import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/usecases/get_article.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/bloc/movies_event.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/bloc/movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteMoviesBloc extends Bloc<RemoteMoviesEvent, RemoteMoviesState> {
  final GetMovieUseCase _getMovieUseCase;

  RemoteMoviesBloc(this._getMovieUseCase)
      : super((const RemoteMoviesLoading())) {
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
