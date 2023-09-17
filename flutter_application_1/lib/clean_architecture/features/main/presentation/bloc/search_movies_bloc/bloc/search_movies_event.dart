abstract class SearchMoviesEvent {
  const SearchMoviesEvent();
}

// class GetMovieByQuery extends SearchMoviesEvent {
//   GetMovieByQuery();
// }

class DebounceSearch extends SearchMoviesEvent {
  final String? query;

  DebounceSearch({this.query});
}
