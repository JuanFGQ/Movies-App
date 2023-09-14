import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/search_entity.dart';

abstract class SearchMovieState extends Equatable {
  final List<SearchEntity>? searchResult;
  final String? query;

  const SearchMovieState({this.searchResult, this.query});

  @override
  List<Object> get props => [searchResult!, query!];
}

class SearchMovieLoading extends SearchMovieState {
  const SearchMovieLoading();
}

class SearchMovieDone extends SearchMovieState {
  const SearchMovieDone(List<SearchEntity> searchResult, String query)
      : super(query: query, searchResult: searchResult);
}
