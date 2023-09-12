import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/clean_architecture/core/constants/constanst.dart';
import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';
import 'package:flutter_application_1/clean_architecture/features/main/data/data_sources/remote/movie_api_service.dart';
import 'package:flutter_application_1/clean_architecture/features/main/data/models/movie_model.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/repositories/movie_repository.dart';

class MoviesRepositoryImpl implements MovieRepository {
  final MoviesApiService _movieApiService;

  MoviesRepositoryImpl(this._movieApiService);

  @override
  Future<DataState<List<MovieModel>>> getMovieArticles() async {
    final response = await _movieApiService.getMovies();

    final movies = (response.data['results'] as List)
        .map((e) => MovieModel.fromJson(e))
        .toList();

    if (response.statusCode == 200) {
      return DataSuccess(movies);
    } else {
      return DataFailed(Exception('failed request status != 200 '));
    }
  }
}

// class MoviesRepositoryImpl implements MovieRepository {
//   final MoviesApiService _movieApiService;

//   MoviesRepositoryImpl(this._movieApiService);

//   @override
//   Future<DataState<List<MovieModel>>> getMovieArticles() async {
//     try {
//       final httpResponse = await _movieApiService.getMovies(apiKey: apiKey);

//       if (httpResponse.response.statusCode == HttpStatus.ok) {
//         return DataSuccess(httpResponse.data);
//       } else {
//         return DataFailed(DioException(
//           requestOptions: httpResponse.response.requestOptions,
//           error: httpResponse.response.statusMessage,
//           type: DioExceptionType.badResponse,
//           response: httpResponse.response,
//         ));
//       }
//     } on DioException catch (e) {
//       return DataFailed(e);
//     }
//   }
// }
