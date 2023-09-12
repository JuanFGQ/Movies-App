import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';

class MoviesApiService {
  final Dio _dio;

  MoviesApiService(this._dio);

  Future<Response<dynamic>> getMovies() async {
    // final queryParameters = <String, dynamic>{'api_key': apiKey};

    try {
      final response = await _dio.get(
          'https://api.themoviedb.org/3/movie/now_playing?api_key=f43317ed52d05cf71a92f42bcb0ee678');

      if (response.statusCode == 200) {
        return response;
      } else {
        throw DataFailed(
            Exception('failed to load data ${response.statusCode}'));
      }
    } catch (e) {
      if (e is SocketException) {
        throw DataFailed(e);
      } else {
        print(e);
        throw DataFailed(Exception('failed to get movie $e'));
      }
    }
  }
}
