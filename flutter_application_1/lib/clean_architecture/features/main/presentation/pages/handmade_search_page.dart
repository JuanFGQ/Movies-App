import 'package:flutter/material.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/search_movies_bloc/bloc/search_movies_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/resources/debounce.dart';
import '../../domain/entities/search_entity.dart';
import '../bloc/search_movies_bloc/bloc/search_movies_bloc.dart';
import '../bloc/search_movies_bloc/bloc/search_movies_state.dart';

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
    // final _debouncer = Debouncer(duration: const Duration(milliseconds: 500));

    final searchBloc = BlocProvider.of<SearchMovieBloc>(context);

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: TextField(
            onChanged: (value) {
              query = value;
              _debouncer.run(() {
                print('ONCHANGED VALUE$value');
                searchBloc.add(DebounceSearch(query: value));
                setState(() {});
              });
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
            itemBuilder: (_, int index) => _MovieItem(results[index]));
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
  final SearchEntity movie;

  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    final movieTag = 'search-${movie.id}';

    return ListTile(
      minLeadingWidth: 72.0,
      leading: SizedBox(
        height: 50,
        width: 50,
        child: Hero(
          tag: movieTag,
          child: (movie.fullPosterImg != null &&
                  movie.fullPosterImg!.startsWith('http'))
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: FadeInImage(
                    fit: BoxFit.fill,
                    placeholder: const AssetImage('assets/barra_colores.gif'),
                    image: NetworkImage(movie.fullPosterImg!),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return const Image(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/no-image.jpg'));
                    },
                  ),
                )
              : const Image(
                  fit: BoxFit.fill, image: AssetImage('assets/no-image.jpg')),
        ),
      ),
      title: Text(movie.title!),
      subtitle: Text(movie.originalTitle!),
      onTap: () {
        Navigator.pushNamed(context, 'detailsScreen', arguments: movie);
      },
    );
  }
}

class _EmptyContainer extends StatelessWidget {
  final Icon icon;
  const _EmptyContainer({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      // ignore: deprecated_member_use
      child: icon,
    );
  }
}
