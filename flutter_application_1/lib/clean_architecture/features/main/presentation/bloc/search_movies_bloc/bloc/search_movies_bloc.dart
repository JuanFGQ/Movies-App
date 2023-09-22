import 'dart:async';

import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/search_entity.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/usecases/search_movie.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/search_movies_bloc/bloc/search_movies_event.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/search_movies_bloc/bloc/search_movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchMovieBloc extends Bloc<SearchMoviesEvent, SearchMovieState> {
  final GetSearchMovieUseCase _getSearchMovieUseCase;

  SearchMovieBloc(this._getSearchMovieUseCase)
      : super(const SearchMovieLoading()) {
    on<DebounceSearch>(getSuggestionByQuery);
  }

  FutureOr<void> getSuggestionByQuery(
      DebounceSearch event, Emitter<SearchMovieState> emit) async {
    final results = await _getSearchMovieUseCase.call(params: event.query);
    if (results is DataSuccess && results.data!.isNotEmpty) {
      emit(SearchMovieDone(results.data!));
    }
    if (results is DataFailed) {
      emit(SearchMovieError(Exception('failed to load ')));
    }
  }
}
