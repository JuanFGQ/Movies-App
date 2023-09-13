// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/models/models.dart';
// import 'package:flutter_application_1/screens/Screens.dart';

// import '../widgets/widgets_butterfile.dart';

// class DetailsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
//     print(movie.title);

//     return Scaffold(
//         body: SafeArea(
//       child: CustomScrollView(
//         slivers: [
//           _CustomAppBar(movie),
//           SliverList(
//             delegate: SliverChildListDelegate([
//               _PosterAndTitle(movie),
//               _OverView(movie),
//               // CastingCards(movie.id),
//             ]),
//           ),
//         ],
//       ),
//     ));
//   }
// }

// class _CustomAppBar extends StatelessWidget {
//   //

//   final Movie movie;

//   const _CustomAppBar(this.movie);

//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       /*with this sliver appbar you can control the width of the appbar itself,
//        unlike the traditional appbar
//        */
//       backgroundColor: Colors.amberAccent,
//       expandedHeight: 200,
//       floating: false,
//       pinned: true,
//       flexibleSpace: FlexibleSpaceBar(
//         centerTitle: true,
//         titlePadding: EdgeInsets.all(0),
//         title: Container(
//           width: double.infinity,
//           alignment: Alignment.bottomCenter,
//           padding: EdgeInsets.only(bottom: 10, left: 10, right: 20),
//           color: Colors.black12,
//           child: Text(
//             movie.title,
//             style: TextStyle(fontSize: 16),
//             textAlign: TextAlign.center,
//           ),
//         ),
//         background: FadeInImage(
//           placeholder: AssetImage('assets/loading.gif'),
//           image: NetworkImage(movie.fullBackdropPath),
//           //FIT is used so that the image expands as much as possible on the screen without being lost
//           // its dimension
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }

// //***** */
// class _PosterAndTitle extends StatelessWidget {
// //***** */

//   final Movie movie;

//   const _PosterAndTitle(this.movie);

//   @override
//   Widget build(BuildContext context) {
//     final TextTheme textTheme = Theme.of(context).textTheme;
//     final size = MediaQuery.of(context).size;

//     return Container(
//       margin: EdgeInsets.only(top: 20),
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         children: [
//           Hero(
//             tag: movie.heroId!,
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(50),
//               child: FadeInImage(
//                 placeholder: AssetImage('assets/no-image.jpg'),
//                 image: NetworkImage(movie.fullBackdropPath),
//                 height: 100,
//                 width: 100,
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           ConstrainedBox(
//             constraints: BoxConstraints(maxWidth: size.width - 150),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   movie.title,
//                   style: Theme.of(context).textTheme.headline5,
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 3,
//                   textAlign: TextAlign.start,
//                 ),
//                 Text(
//                   movie.originalTitle,
//                   style: Theme.of(context).textTheme.subtitle1,
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 2,
//                 ),
//                 Row(
//                   children: [
//                     Icon(Icons.star_border_outlined,
//                         size: 15, color: Colors.grey),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Text('${movie.voteAverage}',
//                         style: Theme.of(context).textTheme.caption)
//                   ],
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// //***** */
// class _OverView extends StatelessWidget {
//   //***** */
//   final Movie movie;

//   const _OverView(this.movie);

//   //***** */
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//       child: Text(
//         movie.overview,
//         textAlign: TextAlign.justify,
//         style: Theme.of(context).textTheme.subtitle1,
//       ),
//     );
//   }
// }
