import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/credits_entity.dart';

abstract class CreditsRepository {
  Future<DataState<List<CastEntity>>> getMovieCredits();
}
