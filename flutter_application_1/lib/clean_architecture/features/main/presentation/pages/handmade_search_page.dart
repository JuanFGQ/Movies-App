import 'package:flutter/cupertino.dart';
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
    // final _debouncer = Debouncer(milliseconds: 5000);

    final searchBloc = BlocProvider.of<SearchMovieBloc>(context);

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: TextField(
            onChanged: (value) {
              // _debouncer.run(() {
              setState(() {
                query = value;
                searchBloc.add(DebounceSearch(query: value));
              });
              // });
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
      return const EmptyContainer(
        icon: Icon(Icons.desktop_access_disabled_rounded),
      );
    }
    // return EmptyContainer(
    //   icon: Icon(Icons.check),
    // );
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
    return const EmptyContainer(
      icon: Icon(Icons.settings_suggest),
    );
  }
}

class _MovieItem extends StatelessWidget {
  final SearchEntity movie;

  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    // final movieTag = 'search-${movie.id}';

    return Container(
      color: Colors.red,
      margin: EdgeInsets.all(20),
      width: double.infinity,
      // height: 20,
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            child: (movie.fullPosterImg != null &&
                    movie.fullPosterImg!.startsWith('http'))
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: FadeInImage(
                        fit: BoxFit.fill,
                        placeholder:
                            const AssetImage('assets/barra_colores.gif'),
                        image: NetworkImage(movie.fullPosterImg!)),
                  )
                : const Image(
                    fit: BoxFit.fill, image: AssetImage('assets/no-image.jpg')),
          ),
          Text(movie.title!)
        ],
      ),
    );

    // return ListTile(
    //   leading: Hero(
    //     tag: movieTag,
    //     child: FadeInImage(
    //       placeholder: const AssetImage('assets/no-image.jpg'),
    //       image: NetworkImage((movie.posterPath != null)
    //           ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
    //           : 'https://i.stack.imgur.com/GNhxO.png'),
    //       fit: BoxFit.cover,
    //     ),
    //   ),
    //   title: Text(movie.title!),
    //   subtitle: Text(movie.originalTitle!),
    //   onTap: () {
    //     Navigator.pushNamed(context, 'detailsScreen', arguments: movie);
    //   },
    // );
  }
}

// class _BuildSuggestions extends StatefulWidget {
//   const _BuildSuggestions();

//   @override
//   State<_BuildSuggestions> createState() => __BuildSuggestionsState();
// }

// class __BuildSuggestionsState extends State<_BuildSuggestions> {
//   WantedPlacesProvider? wantedPlaces;
//   WeatherApiService? weather;
//   NewsService? newsService;
//   @override
//   void initState() {
//     wantedPlaces = Provider.of(context, listen: false);
//     weather = Provider.of<WeatherApiService>(context, listen: false);
//     newsService = Provider.of<NewsService>(context, listen: false);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     wantedPlaces;
//     weather;
//     newsService;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final placesList = Provider.of<WantedPlacesProvider>(context);
// //*SHOW SAVED PLACES
//     if (placesList.places.isEmpty) {
//       return const EmptyContainer();
//     }
//     final weather = Provider.of<WeatherApiService>(context);
//     final newsService = Provider.of<NewsService>(context);

//     return ListView.builder(
//       itemCount: placesList.places.length,
//       itemBuilder: (context, int index) {
//         final wantedPlace = placesList.places[index];
//         return ListTile(
//           leading: const FaIcon(FontAwesomeIcons.clockRotateLeft),
//           title: Text(wantedPlace.placeName),
//           trailing: IconButton(
//               onPressed: () {
//                 placesList.deleteSavePlace(placesList.places[index].id!);
//                 placesList.loadSavedPlaces();
//               },
//               icon: const Icon(Icons.clear)),
//           onTap: () {
//             newsService.activeSearch = true;
//             weather.coords = wantedPlace.placeCoords;
//             Navigator.pushNamed(context, 'ND');
//           },
//         );
//       },
//     );
//   }
// }

class EmptyContainer extends StatelessWidget {
  final Icon icon;
  const EmptyContainer({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      // ignore: deprecated_member_use
      child: icon,
    );
  }
}
