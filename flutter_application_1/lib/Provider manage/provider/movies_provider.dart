// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/helper/debouncer.dart';
// import 'package:flutter_application_1/models/credits_response.dart';
// import 'package:flutter_application_1/models/movie.dart';
// import 'package:flutter_application_1/models/now_playing_response.dart';
// import 'package:flutter_application_1/models/popular_response.dart';
// import 'package:flutter_application_1/models/search_response.dart';

// import 'package:http/http.dart' as http;

// class MoviesProvider extends ChangeNotifier {
//   //

//   String _apiKey = "9a40ae6d1e1998869ed5da1a982327be";
//   String _baseUrl = "api.themoviedb.org";
//   String _language = 'es-ES';

// //******** these are arrangements to save the data of the created methods
//   //such as the getOnDisplayMovies and getPopularMovies methods */
//   List<Movie> onDisplayMovies = [];
//   List<Movie> popularMovies = [];
//   Map<int, List<Cast>> moviesCast = {};
// //****method that serves the same purpose as the one declared in lines 17 and 18 (another way to do it) */
// // the int will be the id of the movie (since it is numeric)
// //
// // the key is the id of the movie("INT") and the result is the rest (List<Cast>>)  Map<int, List<Cast>> moviesCast = {};

// //variable created for the increment in the popular movies method
//   int _popularPage = 0;

// //this method asks me yes or yes for the two values it has inside
//   final debouncer = Debouncer(
//     duration: Duration(milliseconds: 500),
//   );

// //the stream controller will be emitting values
// // through a list, what list? the one with the movies
//   final StreamController<List<Movie>> _suggestionStreamController =
//       new StreamController.broadcast();

//   Stream<List<Movie>> get suggestionStream =>
//       this._suggestionStreamController.stream;

//   MoviesProvider() {
//     print('movies provider inicializando');

//     //*****it must be called for the method to be executed */

//     getOnDisplayMovies();
//     getPopularMovies();
// //stream closure has to be called somewhere, it is mandatory
//   }

// //*****method created to optimize the code that is repeated,
// //*****with the aim that by just calling a method we can
// //***** avoid copying more of the same/
//   /* put the argument
//                             string plus a name that
//                                I assign with the objective
//                                that the value of that endpoint
//                                be dynamic**/
//   Future<String> _getJasonData(String endPoint, [int page = 1]) async {
//     final url = Uri.https(_baseUrl, endPoint,
//         {'api_key': _apiKey, 'language': _language, 'page': '$page'});

//     // Await the http get response, then decode the json-formatted response.
//     final response = await http.get(url);

//     return response.body;
//   }

//   getOnDisplayMovies() async {
//     final jsonData = await _getJasonData('3/movie/now_playing');

//     final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

//     onDisplayMovies = nowPlayingResponse.results;
//     notifyListeners();
//   }

// //*****I have to create another method that will trigger the other data that I need, which would be the popular movies */
// //******IT HAS TO BE AN ASYNCHRONOUS METHOD BECAUSE I HAVE TO MAKE HTTP REQUESTS */

//   getPopularMovies() async {
// //increment is made so that when changing the page the movies are maintained

//     _popularPage++;

//     final jsonData = await this._getJasonData('3/movie/popular', _popularPage);
//     final popularResponse = PopularResponse.fromJson(jsonData);

//     ///******is deconstructed because eventually the popular movies will be called again */
//     ///
//     /// ***** this concatenated method takes the current movies and will always be part of the
//     /// ***** popular movies and will keep the movies even if they change pages

//     popularMovies = [...popularMovies, ...popularResponse.results];
//     // print(popularMovies[0]);
//     notifyListeners();
//   }

// // method to obtain the casting of the movie
//   Future<List<Cast>> getMovieCast(int movieId) async {
//     if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

//     print('pidiendo info al servidor - cast');
// //
//     final jsonData =
//         await this._getJasonData('3/movie/$movieId/credits', _popularPage);
//     final creditsResponse = CreditsResponse.fromJson(jsonData);

//     moviesCast[movieId] = creditsResponse.cast;

//     return creditsResponse.cast;
//   }

// //Method for searching for movies
//   Future<List<Movie>> searchMovies(String query) async {
//     //
//     final url = Uri.https(_baseUrl, '3/search/movie', {
//       'api_key': _apiKey,
//       'language': _language,
//       'query': query,
//     });

//     final response = await http.get(url);
//     final searchResponse = SearchResponse.fromJson(response.body);

//     return searchResponse.results;
//   }

// //

//   void getSuggestionsByQuery(String searchTerm) {
//     debouncer.value = '';
//     debouncer.onValue = (value) async {
//       final results = await searchMovies(value);
//       _suggestionStreamController.add(results);
//     };

//     final timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
//       debouncer.value = searchTerm;
//     });

//     Future.delayed(const Duration(milliseconds: 101))
//         .then((_) => timer.cancel());
//   }
// }
