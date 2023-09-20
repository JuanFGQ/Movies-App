import 'dart:async';

import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';
import 'package:flutter_application_1/clean_architecture/core/resources/debounce.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/search_entity.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/usecases/search_movie.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/search_movies_bloc/bloc/search_movies_event.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/search_movies_bloc/bloc/search_movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SearchMovieBloc extends Bloc<SearchMoviesEvent, SearchMovieState> {
  final GetSearchMovieUseCase _getSearchMovieUseCase;
  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));
  final StreamController<DataState<List<SearchEntity>>>
      _searchResultsController = StreamController.broadcast();

  Stream<DataState<List<SearchEntity>>> get resultsStream =>
      _searchResultsController.stream;

  SearchMovieBloc(this._getSearchMovieUseCase)
      : super(const SearchMovieLoading()) {
    on<DebounceSearch>(
      getSuggestionByQuery,
      // transformer: (events, mapper) {
      //   return events.debounceTime(const Duration(milliseconds: 500));
      // },
    );
  }

  FutureOr<void> getSuggestionByQuery(
      DebounceSearch event, Emitter<SearchMovieState> emit) {}
}
