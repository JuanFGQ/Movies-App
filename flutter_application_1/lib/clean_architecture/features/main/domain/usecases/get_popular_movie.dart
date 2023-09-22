import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';
import 'package:flutter_application_1/clean_architecture/core/usecases/usecase.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/popular_entity.dart';

import '../repositories/movie_repository.dart';

class GetPopularMoviesUseCase
    implements UseCase<DataState<List<PopularResponseEntity>>, void> {
  final MovieRepository _popularMovieRepository;

  GetPopularMoviesUseCase(this._popularMovieRepository);

  @override
  Future<DataState<List<PopularResponseEntity>>> call({void params}) {
    return _popularMovieRepository.getPopularMovies();
  }
}
