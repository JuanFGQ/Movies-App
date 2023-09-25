import 'package:flutter/material.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/movies_bloc/movies_bloc.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/movies_bloc/movies_state.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/widgets/widgets_butterfile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/popular_movies_bloc/bloc/popular_movies_bloc.dart';
import '../bloc/popular_movies_bloc/bloc/popular_movies_state.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cines'),
        elevation: 5,
        actions: [
          IconButton(
              icon: const Icon(Icons.search_outlined),
              onPressed: () {
                Navigator.pushNamed(context, '/searchPage');
              }),
        ],
      ),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<RemoteMoviesBloc, RemoteMoviesState>(
            builder: (context, state) {
              return CardSwiper(movies: state.movies);
            },
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: const Text(
              'Popular Movies',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
            builder: (context, state) {
              return PopularMoviesSlider(
                movies: state.popularMovies!,
              );
            },
          ),
        ],
      ),
    );
  }
}
