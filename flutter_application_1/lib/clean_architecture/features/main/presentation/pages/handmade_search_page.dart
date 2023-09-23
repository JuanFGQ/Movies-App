import 'package:flutter/material.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/movie_entity.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/search_movies_bloc/bloc/search_movies_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/debounce.dart';
import '../../domain/entities/search_entity.dart';
import '../bloc/search_movies_bloc/bloc/search_movies_bloc.dart';
import '../bloc/search_movies_bloc/bloc/search_movies_state.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HandMadeSearchDelegate extends StatefulWidget {
  const HandMadeSearchDelegate({Key? key}) : super(key: key);

  @override
  State<HandMadeSearchDelegate> createState() => _HandMadeSearchDelegateState();
}

class _HandMadeSearchDelegateState extends State<HandMadeSearchDelegate> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final _debouncer = Debouncer(milliseconds: 1000);

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: TextField(
            onChanged: (value) {
              final searchBloc = BlocProvider.of<SearchMovieBloc>(context);
              final stopWatch = Stopwatch()..start();
              query = value;
              if (value.isNotEmpty) {
                _debouncer.run(() {
                  stopWatch.stop();
                  print('${stopWatch.elapsedMilliseconds} ms');
                  searchBloc.add(DebounceSearch(query: value));
                });
              }
              setState(() {});
            },
            decoration: const InputDecoration(
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                label: Text('Search city'),
                border: InputBorder.none,
                focusedBorder: UnderlineInputBorder()),
          ),
        ),
        body: (query.isEmpty)
            ? const _BuildSuggestions()
            : _BuildResults(
                query: query,
              ));
  }
}

class _BuildResults extends StatelessWidget {
  final String query;

  const _BuildResults({required this.query});

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) {
      return const _EmptyContainer(
        icon: Icon(Icons.desktop_access_disabled_rounded),
      );
    }
    return BlocBuilder<SearchMovieBloc, SearchMovieState>(
        builder: (context, state) {
      if (state is SearchMovieLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is SearchMovieError) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is SearchMovieDone) {
        final results = state.searchResult;
        return ListView.builder(
            itemCount: results!.length,
            itemBuilder: (_, int index) =>
                _MovieItem(results[index] as MovieEntity));
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}

class _BuildSuggestions extends StatelessWidget {
  const _BuildSuggestions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _EmptyContainer(
      icon: Icon(Icons.settings_suggest),
    );
  }
}

class _MovieItem extends StatelessWidget {
  final MovieEntity movie;

  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final movieTag = 'search-${movie.id}';

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detailsScreen', arguments: movie);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: Hero(
                  tag: movie.heroId!,
                  child: (movie.fullPosterImg != null &&
                          movie.fullPosterImg!.startsWith('http'))
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: CachedNetworkImage(
                            // fit: BoxFit.cover,
                            imageUrl: movie.fullPosterImg,
                            placeholder: (context, url) => const Image(
                                image: AssetImage('assets/barra_colores.gif')),
                            errorWidget: (context, url, error) => const Image(
                                image: AssetImage('assets/no-image.jpg')),
                          ),
                        )
                      : const Image(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/no-image.jpg'))),
            ),
            Container(
              width: size.width * 0.65,
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    movie.title!,
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    movie.originalTitle!,
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _EmptyContainer extends StatelessWidget {
  final Icon icon;
  const _EmptyContainer({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Image(image: AssetImage('assets/film-strip (1).gif')),
    );
  }
}
