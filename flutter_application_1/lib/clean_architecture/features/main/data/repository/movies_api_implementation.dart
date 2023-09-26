import 'package:flutter_application_1/clean_architecture/core/resources/data_state.dart';
import 'package:flutter_application_1/clean_architecture/features/main/data/data_sources/remote/movie_api_service.dart';
import 'package:flutter_application_1/clean_architecture/features/main/data/models/credits_model.dart';
import 'package:flutter_application_1/clean_architecture/features/main/data/models/movie_model.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/credits_entity.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/movie_entity.dart';

import '../../domain/repositories/movie_repository.dart';

class MoviesRepositoryImpl implements MovieRepository {
  final MoviesApiService _movieApiService;
  Map<int, List<CastEntityDom>> movieCast = {};
  List<MovieEntity> newPopularMoviesList = [];

  MoviesRepositoryImpl(this._movieApiService);

  @override
  Future<DataState<List<MovieEntity>>> getMovieArticles() async {
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

  @override
  Future<DataState<List<CastEntityDom>>> getActorCast(int id) async {
    if (movieCast.containsKey(id)) return DataSuccess(movieCast[id]!);

    final response = await _movieApiService.getMovieCastById(id);
    final credits = (response.data['cast'] as List)
        .map((data) => CastFeature.fromJson(data))
        .toList();

    if (response.statusCode == 200) {
      movieCast[id] = credits;
      return DataSuccess(credits);
    } else {
      return DataFailed(Exception('Failed request'));
    }
//
  }

  @override
  Future<DataState<List<MovieEntity>>> getPopularMovies(int pageNum) async {
    final response = await _movieApiService.getPopularMovies(pageNum);
    final popular = (response.data['results'] as List)
        .map((data) => MovieModel.fromJson(data))
        .toList();

    if (response.statusCode == 200) {
      print('PRINT CREATED LIST $newPopularMoviesList');
      return DataSuccess(popular);
    } else {
      return DataFailed(Exception('Failed request'));
    }
  }

  @override
  Future<DataState<List<MovieEntity>>> getSearch(String searc) async {
    final response = await _movieApiService.getSearchMovie(searc);

    final search = (response.data['results'] as List)
        .map((e) => MovieModel.fromJson(e))
        .toList();

    if (response.statusCode == 200) {
      return DataSuccess(search);
    } else {
      return DataFailed(Exception('Failed request'));
    }
  }
}
