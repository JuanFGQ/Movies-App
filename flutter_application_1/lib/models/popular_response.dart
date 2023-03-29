// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

import 'package:flutter_application_1/models/models.dart';

class PopularResponse {
  PopularResponse({
//****leer de corrido todos los comentarios de aqui hacia abajo */

    //estos son los datos que recibo
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  //******Lo leo del mapa */
  factory PopularResponse.fromJson(String str) =>
      PopularResponse.fromMap(json.decode(str));

  //******Luego hago la conversion de cada uno de los resultados a instacias de mi mapa */
  factory PopularResponse.fromMap(Map<String, dynamic> json) => PopularResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
