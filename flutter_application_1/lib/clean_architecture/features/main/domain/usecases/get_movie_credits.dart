import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';
import 'package:flutter_application_1/clean_architecture/core/usecases/usecase.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/repositories/credits_repository.dart';

import '../entities/credits_entity.dart';

class GetMovieCredits implements UseCase<DataState<List<CreditsEntity>>, void> {
  final CreditsRepository _creditsRepository;

  GetMovieCredits(this._creditsRepository);

  @override
  Future<DataState<List<CreditsEntity>>> call({void params}) {
    return _creditsRepository.getMovieCredits();
  }
}
