import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/helper/debouncer.dart';
import 'package:flutter_application_1/models/credits_response.dart';
import 'package:flutter_application_1/models/movie.dart';
import 'package:flutter_application_1/models/now_playing_response.dart';
import 'package:flutter_application_1/models/popular_response.dart';
import 'package:flutter_application_1/models/search_response.dart';

import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  //

  String _apiKey = "9a40ae6d1e1998869ed5da1a982327be";
  String _baseUrl = "api.themoviedb.org";
  String _language = 'es-ES';

  //******** estos son arreglos para guardar los datos de los metodos creados
  //como por ejemplo los metodos de getOnDisplayMovies y getPopularMovies */
  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

//****metodo que sirve para lo mismo que el declarado en las lineas 17 y 18 (otra forma de hacerlo) */
// el int va a ser el id de la pelicula ( ya que es numerico)
//
// la llave es el id de la pelicula("INT") y el resultado es lo demas (List<Cast>>)
  Map<int, List<Cast>> moviesCast = {};

//variable creada para el incremento en el metodo popular movies
  int _popularPage = 0;

//este metodo me pide si o si los dos valores que tiene dentro
  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
  );

//el stream controller va a estar emitiendo valores
// a traves de una lista, que lista? la de las peliculas movies
  final StreamController<List<Movie>> _suggestionStreamController =
      new StreamController.broadcast();

  Stream<List<Movie>> get suggestionStream =>
      this._suggestionStreamController.stream;

  MoviesProvider() {
    print('movies provider inicializando');

    //*****se tiene que mandar a llamar para que se ejecute el metodo */
    getOnDisplayMovies();
    getPopularMovies();

//se tiene que llamar el cierre del stream en algun sitio, es obligatorio
  }

//*****metodo creado para optimizar el codigo que se repite,
//*****con el objetivo de que con solo llamar un metodo podamos
//***** evitar copiar mas de lo mismo/
  /*se coloca el argumento
                              string mas un nombre que 
                              yo asigno con el objetivo
                              de que el valor de ese endpoint 
                              sea dinamico*/
  Future<String> _getJasonData(String endPoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endPoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJasonData('3/movie/now_playing');

    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  //*****Tengo que crear otro metodo que me dispare el otro dato que necesito que seria el popular movies */

  //******TIENE QUE SER UN METODO ASYNCRONO PORQUE TENGO QUE HACER PETICIONES HTTP */
  getPopularMovies() async {
    //se hace incremento para que al cambiar de pagina se mantengan las peliculas
    _popularPage++;

    final jsonData = await this._getJasonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);

    ///******se desestructura porque eventualmente el popular movies se va a volver a llamar */

    ///
    /// *****     este metodo concatenado toma las peliculas actuales y siempre va a ser parte de las
    /// *****     popular movies y va a mantener las peliculas asi se cambien de pagina
    popularMovies = [...popularMovies, ...popularResponse.results];
    // print(popularMovies[0]);
    notifyListeners();
  }

// metodo para obtener el casting de la pelicula
  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    print('pidiendo info al servidor - cast');

    final jsonData =
        await this._getJasonData('3/movie/$movieId/credits', _popularPage);
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  //Metodo para la busqueda de peliculas

  Future<List<Movie>> searchMovies(String query) async {
    //
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

//

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      print('tenemos valor a buscar: $value');
      final results = await searchMovies(value);
      _suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 100), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 101))
        .then((_) => timer.cancel());
  }
}
