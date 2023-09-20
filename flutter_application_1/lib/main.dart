import 'package:flutter/material.dart';
import 'package:flutter_application_1/clean_architecture/config/routes/routes.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/actors_cast_bloc/bloc/actor_cast_bloc.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/actors_cast_bloc/bloc/actor_cast_event.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/movies_bloc/movies_bloc.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/movies_bloc/movies_event.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/popular_movies_bloc/bloc/popular_movies_bloc.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/popular_movies_bloc/bloc/popular_movies_event.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/search_movies_bloc/bloc/search_movies_bloc.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/search_movies_bloc/bloc/search_movies_event.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/pages/initial_page.dart';
import 'package:flutter_application_1/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<PopularMoviesBloc>(
            create: (context) => sl()..add(const GetPopularMovies())),
        BlocProvider<RemoteMoviesBloc>(
            create: (context) => sl()..add(const GetMovies())),
        BlocProvider<ActorsCastBloc>(
            create: (context) => sl()..add(GetActorsCast())),
        BlocProvider<SearchMovieBloc>(
            create: (context) => sl()..add(DebounceSearch())),
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          home: InitialPage()),

      // BlocProvider<RemoteMoviesBloc>(
      //   create: (context) => sl()..add(const GetMovies()),
      //   child: const MaterialApp(
      //       debugShowCheckedModeBanner: false,
      //       onGenerateRoute: AppRoutes.onGenerateRoute,
      //       home: InitialPage()),
      // ),
    );
  }
}
