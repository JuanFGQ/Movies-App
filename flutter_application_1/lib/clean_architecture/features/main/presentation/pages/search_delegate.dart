import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/search_entity.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/search_movies_bloc/bloc/search_movies_bloc.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/search_movies_bloc/bloc/search_movies_event.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/search_movies_bloc/bloc/search_movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/debounce.dart';

// class Debouncer {
//   Debouncer({required this.milliseconds});

//   final int milliseconds;
//   VoidCallback? action;
//   Timer? _timer;

//   void run(VoidCallback action) {
//     //If a timer is send, first the previous counter must be cancelled
//     if (null != _timer) {
//       _timer?.cancel();
//     }
//     _timer = Timer(
//       Duration(milliseconds: milliseconds),
//       action,
//     );
//   }

//   void cancel() => _timer?.cancel();
// }

class MovieSearchDelegate extends SearchDelegate {
  final _debouncer = Debouncer(milliseconds: 4000);
  @override
  String get searchFieldLabel => 'Buscar pelicula';

// @override
  AppBar buildAppBar(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchMovieBloc>(context);

    return AppBar(
      title: const Text('Search'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            query = '';
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: TextField(
          onChanged: (value) {
            _debouncer.run(() {
              // Aquí puedes enviar la información a tu bloc
              // El código dentro de esta función se ejecutará después del retraso especificado
              // y evitará que se realicen múltiples llamadas innecesarias al bloc mientras el usuario sigue escribiendo.
              // Por ejemplo:
              // bloc.search(query);
              searchBloc.add(DebounceSearch(query: value));
            });
          },
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 16.0, top: 20.0),
          ),
        ),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
//method to add the x that deletes what was written
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
      // buildSearchBar(context)
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
//back arrow to exit the search
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('results');
  }

  Widget _emptyContainer() {
    return const Center(
      child: Icon(
        Icons.movie_filter,
        color: Colors.red,
        size: 100,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //   if (query.isEmpty) {
    //     return _emptyContainer();
    //   }

    // final searchBloc = BlocProvider.of<SearchMovieBloc>(context);

    //   searchBloc.add(DebounceSearch(query: query));
    // _debouncer.run(() {
    //   searchBloc.add(DebounceSearch(query: 'nemo'));
    // });

    return BlocBuilder<SearchMovieBloc, SearchMovieState>(
        builder: (context, state) {
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

// return StreamBuilder<DataState<List<SearchEntity>>>(
//     stream: searchBloc.resultsStream,
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const CircularProgressIndicator();
//       } else if (snapshot.hasError) {
//         return Text('Error: ${snapshot.error}');
//       } else if (snapshot.hasData) {
//         final movies = snapshot.data!.data;
//         // searchBloc.add(SearchMovieDone(movies));

//         if (movies!.isEmpty) {
//           return _emptyContainer();
//         }

//         return ListView.builder(
//             itemCount: movies.length,
//             itemBuilder: (_, int index) => _MovieItem(movies[index]));
//       } else {
//         return _emptyContainer();
//       }
//     });

// if (state.searchResult!.isEmpty) return _emptyContainer();

// *THIS INSTANCE WAS CREATED SO THAT WHEN THE RESULTS ARE SHOWN
// *YOU CAN ENTER THE DETAILS SCREEN...
// *THIS IS DONE TO REQUEST THE INFORMATION AND ENTER IT

class _MovieItem extends StatelessWidget {
  final SearchEntity movie;

  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    // movie.heroId = 'search-${movie.id}';

    return ListTile(
      leading: FadeInImage(
        placeholder: const AssetImage('assets/no-image.jpg'),
        image: NetworkImage((movie.posterPath != null)
            ? 'https://image.tmdb.org/t/p/w100${movie.posterPath}'
            : 'https://i.stack.imgur.com/GNhxO.png'),
        fit: BoxFit.cover,
      ),
      title: Text(movie.title!),
      subtitle: Text(movie.originalTitle!),
      onTap: () {
        Navigator.pushNamed(context, 'detailsScreen', arguments: movie);
      },
    );
  }
}
//

// import 'dart:async';
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/search_movies_bloc/bloc/search_movies_bloc.dart';
// import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/search_movies_bloc/bloc/search_movies_event.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CustomDebouncer {
//   final Duration delay;
//   late VoidCallback action;
//   late Timer _timer;

//   CustomDebouncer({required this.delay});

//   void run(VoidCallback action) {
//     if (_timer != null && _timer.isActive) {
//       _timer.cancel();
//     }
//     _timer = Timer(delay, action);
//   }

//   void cancel() {
//     if (_timer != null && _timer.isActive) {
//       _timer.cancel();
//     }
//   }
// }

// class MovieSearchDelegate extends SearchDelegate<String> {
//   final CustomDebouncer _debouncer =
//       CustomDebouncer(delay: Duration(milliseconds: 500));

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = '';
//         },
//         icon: Icon(Icons.clear),
//       ),
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, null);
//       },
//       icon: Icon(Icons.arrow_back),
//     );
//     // throw UnimplementedError();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // Build your suggestions UI here
//     return ListView(
//       children: const <Widget>[
//         // Your suggestion items
//       ],
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // Build your search results UI here
//     return ListView(
//       children: const <Widget>[
//         // Your search results items
//       ],
//     );
//   }

//   Widget buildSearchBar(BuildContext context) {
//     final searchBloc = BlocProvider.of<SearchMovieBloc>(context);

//     return AppBar(
//       title: const Text('Search'),
//       actions: <Widget>[
//         IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: () {
//             query = '';
//           },
//         ),
//       ],
//       bottom: PreferredSize(
//         preferredSize: Size.fromHeight(56.0),
//         child: TextField(
//           onChanged: (value) {
//             _debouncer.run(() {
//               // Aquí puedes enviar la información a tu bloc
//               // El código dentro de esta función se ejecutará después del retraso especificado
//               // y evitará que se realicen múltiples llamadas innecesarias al bloc mientras el usuario sigue escribiendo.
//               // Por ejemplo:
//               // bloc.search(query);
//               searchBloc.add(DebounceSearch(query: query));
//             });
//           },
//           decoration: const InputDecoration(
//             hintText: 'Search...',
//             border: InputBorder.none,
//             contentPadding: EdgeInsets.only(left: 16.0, top: 20.0),
//           ),
//         ),
//       ),
//     );
//   }
// }
