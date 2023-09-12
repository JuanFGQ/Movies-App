import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/clean_architecture/features/main/data/models/movie_model.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/movie_entity.dart';
import 'package:flutter_application_1/models/movie.dart';

class CardSwiper extends StatelessWidget {
  final List<MovieEntity>? movies;
  // final MovieEntity movies;

  //tengo que crear otro modelo

  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    ///***this is to solve the error that appeared when it was just loading
    ///****the image...what is done is to create a loading circle so that the image cannot be seen
    ///****red screen....this is created before creating the widget */ */
    if (this.movies!.length == 0) {
      ///****this says: if the length(length) of the movies is 0 show the load cycle */
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: size.height * 0.6,
      child: Swiper(
        itemCount: movies!.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.5,
        itemBuilder: (_, int index) {
          //
          final movie = movies![index];

          // movie.heroId = 'swiper-${movie.id}';

          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: '1',
              // 'movie.id!,'
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage((movie.posterPath != null)
                      ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                      : 'https://i.stack.imgur.com/GNhxO.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
