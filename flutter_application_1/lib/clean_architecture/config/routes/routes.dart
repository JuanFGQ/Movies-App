import 'package:flutter/material.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/movie_entity.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/pages/handmade_search_page.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/pages/initial_page.dart';

import '../../features/main/presentation/pages/movie_details_screen.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const InitialPage());

      case '/detailsScreen':
        return _materialRoute(MovieDetailsScreen(
          movie: settings.arguments as MovieEntity,
        ));

      case '/searchPage':
        return _materialRoute(const HandMadeSearchDelegate());

      default:
        return _materialRoute(const InitialPage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
