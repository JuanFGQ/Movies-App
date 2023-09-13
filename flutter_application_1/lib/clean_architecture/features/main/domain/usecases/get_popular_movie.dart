import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';
import 'package:flutter_application_1/clean_architecture/core/usecases/usecase.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/popular_entity.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/repositories/popular_repository.dart';

class GetPopularMoviesUserCase
    implements UseCase<DataState<List<PopularEntity>>, void> {
  final PopularMovieRepository _popularMovieRepository;

  GetPopularMoviesUserCase(this._popularMovieRepository);

  @override
  Future<DataState<List<PopularEntity>>> call({void params}) {
    return _popularMovieRepository.getPopularMovies();
  }
}
