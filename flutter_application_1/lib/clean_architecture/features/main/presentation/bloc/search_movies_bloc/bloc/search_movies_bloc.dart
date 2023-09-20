import 'dart:async';

import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/search_entity.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/usecases/search_movie.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/search_movies_bloc/bloc/search_movies_event.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/search_movies_bloc/bloc/search_movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../../core/resources/debounce.dart';

class SearchMovieBloc extends Bloc<SearchMoviesEvent, SearchMovieState> {
  final GetSearchMovieUseCase _getSearchMovieUseCase;
  // final debouncer = Debouncer(milliseconds: 500);
  // final StreamController<DataState<List<SearchEntity>>>
  //     _searchResultsController = StreamController.broadcast();

  // Stream<DataState<List<SearchEntity>>> get resultsStream =>
  //     _searchResultsController.stream;

  SearchMovieBloc(this._getSearchMovieUseCase)
      : super(const SearchMovieLoading()) {
    on<DebounceSearch>(
      getSuggestionByQuery,
      // transformer: (events, mapper) {
      //   return events.debounceTime(const Duration(milliseconds: 500));
      // },
    );
  }

  void getSuggestionByQuery(
      DebounceSearch event, Emitter<SearchMovieState> emit) async {
    // debouncer.value = event.query;
    // debouncer.onValue = (value) async {
    final results = await _getSearchMovieUseCase.call(params: event.query);

    if (results is DataSuccess && results.data!.isNotEmpty) {
      emit(SearchMovieDone(results.data!));
    }
    if (results is DataFailed) {
      emit(SearchMovieError(results.error!));
    }
    // };
  }

  // void getSearchMovies(
  //     GetMovieByQuery event, Emitter<SearchMovieState> emit) async {
  //   final result = await _getSearchMovieUseCase.call();

  //   if (result is DataSuccess && result.data!.isNotEmpty) {
  //     emit(SearchMovieDone(result.data!));
  //   }
  //   if (result is DataFailed) {
  //     emit(SearchMovieError(result.error!));
  //   }
  // }

  // void getSuggestionByQuery(
  //     GetDebouncedSearch event, Emitter<SearchMovieState> emit) {
  //   debouncer.value = event.query;
  //   debouncer.onValue = (value) async {
  //     final results = await _getSearchMovieUseCase.call(params: value);

  //     if (results is DataSuccess && results.data!.isNotEmpty) {
  //       _searchResultsController.add(results);
  //     }

  //     if (results is DataFailed) {
  //       _resultsController.addError(results.error!);
  //     }
  //     final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
  //       debouncer.value = event.query;
  //     });
  //     Future.delayed(const Duration(milliseconds: 201))
  //         .then((_) => timer.cancel());
  //   };
  // }

  // void getSuggestionByQuery(
  //     GetDebouncedSearch event, Emitter<SearchMovieState> emit) {
  //   debouncer.value = event.query;
  //   debouncer.onValue = (value) async {
  //     final results = await _getSearchMovieUseCase.call(params: value);

  //     if (results is DataSuccess && results.data!.isNotEmpty) {
  //       _resultsController.add(results);

  //       emit(SearchMovieDone(results.data!));
  //     }

  //     if (results is DataFailed) {
  //       _resultsController.addError(results.error!);
  //       // emit(SearchMovieError(results.error!));
  //     }
  //     final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
  //       debouncer.value = event.query;
  //     });
  //     Future.delayed(const Duration(milliseconds: 201))
  //         .then((_) => timer.cancel());
  //   };
  // }
}
