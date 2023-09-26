abstract class PopularMoviesEvent {}

class GetPopularMovies extends PopularMoviesEvent {
  final int? pageNum;

  GetPopularMovies({this.pageNum = 1});
}
