// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_application_1/provider/movies_provider.dart';
// import 'package:flutter_application_1/screens/Screens.dart';
// import 'package:provider/provider.dart';

// import 'clean_architecture/features/main/presentation/pages/pages_butterfile.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   ByteData data =
//       await PlatformAssetBundle().load('assets/lets-encrypt-r3.pem');
//   SecurityContext.defaultContext
//       .setTrustedCertificatesBytes(data.buffer.asUint8List());

//   runApp(AppState());
// }

// class AppState extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false),
//       ],
//       child: MyApp(),
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'peliculas app',
//       initialRoute: 'home',
//       routes: {
//         'home': (_) => HomeScreen(),
//         'details': (_) => DetailsScreen(),
//       },
//       theme: ThemeData.light()
//           .copyWith(appBarTheme: AppBarTheme(color: Colors.amberAccent)),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_1/clean_architecture/config/routes/routes.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/bloc/movies_bloc.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/bloc/movies_event.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/pages/initial_page.dart';
import 'package:flutter_application_1/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteMoviesBloc>(
      create: (context) => sl()..add(const GetMovies()),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          home: InitialPage()),
    );
  }
}
