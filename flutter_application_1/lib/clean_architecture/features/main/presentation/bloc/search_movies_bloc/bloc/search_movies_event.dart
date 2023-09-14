abstract class SearchMoviesEvent {
  const SearchMoviesEvent();
}

class GetMovieByQuery extends SearchMoviesEvent {
  final String query;

  GetMovieByQuery({required this.query});
}
