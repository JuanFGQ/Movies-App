import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/movies_provider.dart';
import 'package:flutter_application_1/search/search_delegate.dart';
import 'package:flutter_application_1/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //

    final moviesProvider = Provider.of<MoviesProvider>(context);

    print(moviesProvider.onDisplayMovies);

    //
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cines'),
        elevation: 5,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () =>
                showSearch(context: context, delegate: MovieSearchDelegate()),
          ),
        ],
      ),

      //

      //este metodo me permite hacer scroll, cuando los elementos no caben en la pantalla
      body: SingleChildScrollView(
        child: Column(
          children: [
            //tarjetas principales
            CardSwiper(movies: moviesProvider.onDisplayMovies),

            //slider de pelicuas
            MovieSlider(
              movies: moviesProvider.popularMovies,
              title: 'populares',
              onNextPage: () => moviesProvider.getPopularMovies(),
              //{
              // print('hola mundo');
              //}, //opcional
            ),
          ],
        ),
      ),
    );
  }
}
