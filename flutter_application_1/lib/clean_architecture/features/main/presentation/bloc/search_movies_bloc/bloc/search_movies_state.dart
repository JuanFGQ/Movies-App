import 'package:equatable/equatable.dart';

import '../../../../domain/entities/movie_entity.dart';

abstract class SearchMovieState extends Equatable {
  final List<MovieEntity>? searchResult;
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
    List<MovieEntity> searchResult,
  ) : super(searchResult: searchResult);
}

class SearchMovieError extends SearchMovieState {
  const SearchMovieError(Exception error) : super(error: error);
}
