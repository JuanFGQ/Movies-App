import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/search_entity.dart';

abstract class SearchRepository {
  Future<DataState<List<SearchEntity>>> getSearch();
}
