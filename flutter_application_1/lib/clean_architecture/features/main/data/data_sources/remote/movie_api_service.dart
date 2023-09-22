import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';

class MoviesApiService {
  final Dio _dio;

  MoviesApiService(this._dio);

  Future<Response<dynamic>> getMovies() async {
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

  Future<Response<dynamic>> getPopularMovies() async {
    try {
      final response = await _dio.get(
          'https://api.themoviedb.org/3/movie/popular?api_key=f43317ed52d05cf71a92f42bcb0ee678');
      if (response.statusCode == 200) {
        return response;
      } else {
        throw DataFailed(
            Exception('Failed to load data ${response.statusCode}'));
      }
    } catch (e) {
      if (e is SocketException) {
        throw DataFailed(e);
      } else {
        throw DataFailed(Exception('Failed to get popular movies $e'));
      }
    }
  }

  Future<Response<dynamic>> getMovieCastById(int movieId) async {
    try {
      final response = await _dio.get(
          'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=f43317ed52d05cf71a92f42bcb0ee678');

      if (response.statusCode == 200) {
        return response;
      } else {
        throw DataFailed(
            Exception('Failed to load data ${response.statusCode}'));
      }
    } catch (e) {
      if (e is SocketException) {
        throw DataFailed(Exception(e));
      } else {
        throw DataFailed(Exception('Failed to get credits $e'));
      }
    }
  }

  Future<Response<dynamic>> getSearchMovie(String query) async {
    try {
      final response = await _dio.get(
          'https://api.themoviedb.org/3/search/movie?api_key=f43317ed52d05cf71a92f42bcb0ee678&query=$query');

      if (response.statusCode == 200) {
        return response;
      } else {
        print('ERROR on movieApiService ${response.statusCode}');
        throw DataFailed(
            Exception('Failed to load data ${response.statusCode}'));
      }
    } catch (e) {
      if (e is SocketException) {
        print('ERROR on movieApiService $e');
        throw DataFailed(Exception(e));
      } else {
        print('ERROR on movieApiService $e');
        throw DataFailed(Exception('Failed to get credits $e'));
      }
    }
  }
}
