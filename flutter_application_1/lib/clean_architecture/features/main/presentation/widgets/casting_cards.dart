import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/credits_entity.dart';
import '../bloc/actors_cast_bloc/bloc/actor_cast_bloc.dart';
import '../bloc/actors_cast_bloc/bloc/actor_cast_state.dart';
import 'loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CastingCards extends StatelessWidget {
  //
  // final int movieId;
//
  // const CastingCards({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // BlocProvider.of<ActorsCastBloc>(context)
    //     .add(GetActorsCast(castID: movieId));

//
    return BlocBuilder<ActorsCastBloc, ActorCastState>(
        builder: (context, state) {
      if (state is ActorCastLoading) {
        return const LoadingWidget();
      }
      if (state is ActorCastDone) {
        // final cast = state.actorsCast;

        return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: size.height * 0.8,
          child: ListView.builder(
              itemCount: state.actorsCast!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, int index) =>
                  _CastCard(state.actorsCast![index])),
        );
      } else {
        return Container(
          constraints: const BoxConstraints(maxWidth: 150),
          height: size.height * 0.8,
          child: const CupertinoActivityIndicator(),
        );
      }
    });
  }
}

class _CastCard extends StatelessWidget {
//

  final CastEntityDom actor;
  const _CastCard(this.actor);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: size.width * 0.3,
      // height: 120,
      // color: Colors.amber,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: actor.fullProfilePath,
              placeholder: (context, url) =>
                  const Image(image: AssetImage('assets/barra_colores.gif')),
              errorWidget: (context, url, error) =>
                  const Image(image: AssetImage('assets/no-image.jpg')),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(actor.name!,
              maxLines: 3,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
