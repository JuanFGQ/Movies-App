import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/search_entity.dart';

abstract class SearchMovieState extends Equatable {
  final List<SearchEntity>? searchResult;
  // final String? query;

  final Exception? error;

  const SearchMovieState({
    this.error,
    this.searchResult,
    // this.query
  });

  @override
  List<Object> get props =>
      [searchResult ?? [], error ?? Exception('No error Messaje')];
}

class SearchMovieLoading extends SearchMovieState {
  const SearchMovieLoading();
}

class SearchMovieDone extends SearchMovieState {
  const SearchMovieDone(
    List<SearchEntity> searchResult,
  ) : super(searchResult: searchResult);
}

class SearchMovieError extends SearchMovieState {
  const SearchMovieError(Exception error) : super(error: error);
}
