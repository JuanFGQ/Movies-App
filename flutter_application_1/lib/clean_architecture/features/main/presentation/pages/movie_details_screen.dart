import 'package:flutter/material.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/movie_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/widgets/casting_cards.dart';

class MovieDetailsScreen extends StatelessWidget {
  final MovieEntity? movie;
  const MovieDetailsScreen({Key? key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final MovieEntity movie =
    //     ModalRoute.of(context)!.settings.arguments as MovieEntity;

    print(movie!.title);

    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        slivers: [
          _CustomAppBar(movie!),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie!),
              _OverView(movie!),
              CastingCards(
                movieId: movie!.id!,
              )
            ]),
          ),
        ],
      ),
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  //

  final MovieEntity movie;

  const _CustomAppBar(this.movie);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      /*with this sliver appbar you can control the width of the appbar itself,
       unlike the traditional appbar
       */
      backgroundColor: Colors.amberAccent,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 20),
          color: Colors.black12,
          child: Text(
            movie.title!,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: movie.fullPosterImg,
          placeholder: (context, url) =>
              const Image(image: AssetImage('assets/barra_colores.gif')),
          errorWidget: (context, url, error) =>
              const Image(image: AssetImage('assets/no-image.jpg')),
        ),
      ),
    );
  }
}

//***** */
class _PosterAndTitle extends StatelessWidget {
//***** */

  final MovieEntity movie;

  const _PosterAndTitle(this.movie);

  @override
  Widget build(BuildContext context) {
    final movieTag = 'search-${movie.id}';

    // final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.1,
      width: size.width * 0.1,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movieTag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                // fit: BoxFit.cover,
                imageUrl: movie.fullPosterImg,
                placeholder: (context, url) =>
                    const Image(image: AssetImage('assets/barra_colores.gif')),
                errorWidget: (context, url, error) =>
                    const Image(image: AssetImage('assets/no-image.jpg')),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title!,
                  style: Theme.of(context).textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  textAlign: TextAlign.start,
                ),
                Text(
                  movie.originalTitle!,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    const Icon(Icons.star_border_outlined,
                        size: 15, color: Colors.grey),
                    const SizedBox(
                      width: 5,
                    ),
                    Text('${movie.voteAverage}',
                        style: Theme.of(context).textTheme.caption)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  final MovieEntity movie;

  const _OverView(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        movie.overview!,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
