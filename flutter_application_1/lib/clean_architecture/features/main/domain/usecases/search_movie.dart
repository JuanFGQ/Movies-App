import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';
import 'package:flutter_application_1/clean_architecture/core/usecases/usecase.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/search_entity.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/repositories/search%20repository.dart';

class GetSearchMovieUseCase
    implements UseCase<DataState<List<SearchEntity>>, void> {
  final SearchRepository _searchRepository;

  GetSearchMovieUseCase(this._searchRepository);

  @override
  Future<DataState<List<SearchEntity>>> call({void params}) {
    return _searchRepository.getSearch();
  }
}
