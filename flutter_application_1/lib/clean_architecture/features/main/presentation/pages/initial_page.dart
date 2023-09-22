import 'package:flutter/material.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/movies_bloc/movies_bloc.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/movies_bloc/movies_state.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/pages/handmade_search_page.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/widgets/widgets_butterfile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocBuilder<RemoteMoviesBloc, RemoteMoviesState>(
        builder: (_, state) {
      if (state is RemoteMoviesLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is RemoteMoviesError) {
        return const Center(child: Icon(Icons.refresh));
      }
      if (state is RemoteMoviesDone) {
        return SingleChildScrollView(
          child: Column(
            children: [
              CardSwiper(movies: state.movies),
              PopularMoviesSlider(),
            ],
          ),
        );
      }
      return const SizedBox();
    });
  }
}
