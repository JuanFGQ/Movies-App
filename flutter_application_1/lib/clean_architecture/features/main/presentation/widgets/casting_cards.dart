// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../domain/entities/credits_entity.dart';
// import '../bloc/actors_cast_bloc/bloc/actor_cast_bloc.dart';
// import '../bloc/actors_cast_bloc/bloc/actor_cast_state.dart';
// import 'loading_widget.dart';

// class CastingCards extends StatelessWidget {
//   //
//   final int movieId;

//   const CastingCards(this.movieId);

//   @override
//   Widget build(BuildContext context) {
// //2
//     // final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

//     return BlocBuilder<ActorsCastBloc, ActorCastState>(
//         builder: (context, state) {
//       if (state is ActorCastLoading) {
//         return LoadingWidget();
//       }
//       if (state is ActorCastDone) {
//         return Container(
//           margin: const EdgeInsets.only(bottom: 30),
//           width: double.infinity,
//           height: 200,
//           //color: Colors.red,
//           child: ListView.builder(
//               itemCount: state.actorsCast!.length,
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (_, int index) => _CastCard(cast[index])),
//         );
//       }
//     });
//   }
// }

// //   return Container(
// //     constraints: const BoxConstraints(maxWidth: 150),
// //     height: 180,
// //     child: const CupertinoActivityIndicator(),
// //   );

// // final List<Cast> cast = snapshot.data!;

// class _CastCard extends StatelessWidget {
// //

//   final CastEntity actor;
//   const _CastCard(this.actor);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 10),
//       width: 110,
//       height: 110,
//       //color: Colors.amber,
//       child: Column(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: FadeInImage(
//               placeholder: const AssetImage('assets/no-image.jpg'),
//               image: NetworkImage(actor.fullProfilePath),
//               height: 140,
//               width: 100,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Text(
//             actor.name!,
//             maxLines: 3,
//             overflow: TextOverflow.ellipsis,
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }
