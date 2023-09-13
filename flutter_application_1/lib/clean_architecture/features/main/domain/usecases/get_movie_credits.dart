import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';
import 'package:flutter_application_1/clean_architecture/core/usecases/usecase.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/repositories/movie_repository.dart';

import '../entities/credits_entity.dart';

class GetActorsCastUseCase
    implements UseCase<DataState<List<CastEntity>>, void> {
  final MovieRepository _creditsRepository;

  GetActorsCastUseCase(this._creditsRepository);

  @override
  Future<DataState<List<CastEntity>>> call({void params}) {
    return _creditsRepository.getMovieCredits();
  }
}
