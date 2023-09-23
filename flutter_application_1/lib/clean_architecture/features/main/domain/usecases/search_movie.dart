import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';
import 'package:flutter_application_1/clean_architecture/core/usecases/usecase.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/movie_entity.dart';

import '../repositories/movie_repository.dart';

class GetSearchMovieUseCase
    implements UseCase<DataState<List<MovieEntity>>, String> {
  final MovieRepository _searchRepository;

  GetSearchMovieUseCase(this._searchRepository);

  @override
  Future<DataState<List<MovieEntity>>> call({String? params}) {
    return _searchRepository.getSearch(params ?? "");
  }
}
