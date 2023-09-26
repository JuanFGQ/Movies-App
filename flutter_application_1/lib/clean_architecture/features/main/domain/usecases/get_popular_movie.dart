import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';
import 'package:flutter_application_1/clean_architecture/core/usecases/usecase.dart';

import '../entities/movie_entity.dart';
import '../repositories/movie_repository.dart';

class GetPopularMoviesUseCase
    implements UseCase<DataState<List<MovieEntity>>, int> {
  final MovieRepository _popularMovieRepository;

  GetPopularMoviesUseCase(this._popularMovieRepository);

  @override
  Future<DataState<List<MovieEntity>>> call({int? params}) {
    return _popularMovieRepository.getPopularMovies(params!);
  }
}
