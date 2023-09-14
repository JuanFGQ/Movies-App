import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';
import 'package:flutter_application_1/clean_architecture/core/usecases/usecase.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/search_entity.dart';

import '../repositories/movie_repository.dart';

class GetSearchMovieUseCase implements UseCase<List<SearchEntity>, String> {
  final MovieRepository _searchRepository;

  GetSearchMovieUseCase(this._searchRepository);

  @override
  Future<List<SearchEntity>> call({String? params}) {
    return _searchRepository.getSearch(params!);
  }
}
