import 'package:flutter/material.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/pages/initial_page.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/pages/search_delegate.dart';

import '../../features/main/presentation/pages/movie_details_screen.dart';

class AppRoutes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(InitialPage());

      // case '/detailsScreen':
      //   return _materialRoute(MovieDetailsScreen());

      // case '/searchPage' :
      // return _materialRoute(MovieSearchDelegate());

      default:
        return _materialRoute(InitialPage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
