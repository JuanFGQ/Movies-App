import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/clean_architecture/core/constants/constanst.dart';
import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';
import 'package:flutter_application_1/clean_architecture/features/main/data/data_sources/remote/movie_api_service.dart';
import 'package:flutter_application_1/clean_architecture/features/main/data/models/credits_model.dart';
import 'package:flutter_application_1/clean_architecture/features/main/data/models/movie_model.dart';
import 'package:flutter_application_1/clean_architecture/features/main/data/models/popular_model.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/credits_entity.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/popular_entity.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/search_entity.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/repositories/credits_repository.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/repositories/movie_repository.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/repositories/popular_repository.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/repositories/search%20repository.dart';

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
      return DataFailed(Exception('failed request status'));
    }
  }
}

class PopularMoviesRepositoryImpl implements PopularMovieRepository {
  final MoviesApiService _moviesApiService;

  PopularMoviesRepositoryImpl(this._moviesApiService);

  @override
  Future<DataState<List<PopularMoviesModel>>> getPopularMovies() async {
    final response = await _moviesApiService.getPopularMovies();
    final popular = (response.data['results'] as List)
        .map((data) => PopularMoviesModel.fromJson(data))
        .toList();

    if (response.statusCode == 200) {
      return DataSuccess(popular);
    } else {
      return DataFailed(Exception('Failed request'));
    }
  }
}

class MovieCastRepositoryImp implements CreditsRepository {
  final MoviesApiService _moviesApiService;

  MovieCastRepositoryImp(this._moviesApiService);

  @override
  Future<DataState<List<CreditsEntity>>> getMovieCredits() async {
    final response = await _moviesApiService.getMovieCastById(1);
    final credits = (response.data['results'] as List)
        .map((data) => CastModel.fromJson(data))
        .toList();

    if (response.statusCode == 200) {
      return DataSuccess(credits);
    } else {
      return DataFailed(Exception('Failed request'));
    }
  }
}
//  class SearchMovieRepositoryImpl implements SearchRepository{
//   final MoviesApiService _moviesApiService;

//   @override
//   Future<DataState<List<SearchEntity>>> getSearch() {
// final response = await _movieApiService


//   }

//   }