import 'dart:async';

import 'package:flutter_application_1/clean_architecture/features/main/domain/usecases/search_movie.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/search_movies_bloc/bloc/search_movies_event.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/search_movies_bloc/bloc/search_movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchMovieBloc extends Bloc<SearchMoviesEvent, SearchMovieState> {
  final GetSearchMovieUseCase _getSearchMovieUseCase;

  SearchMovieBloc(this._getSearchMovieUseCase) : super(SearchMovieLoading()) {
    on<GetMovieByQuery>(onGetSearchMovieResult);
  }

  void onGetSearchMovieResult(
      GetMovieByQuery event, Emitter<SearchMovieState> emit) async {
    final movieResults = await _getSearchMovieUseCase.call(params: event.query);
    emit(SearchMovieDone(movieResults, event.query));
  }
}
