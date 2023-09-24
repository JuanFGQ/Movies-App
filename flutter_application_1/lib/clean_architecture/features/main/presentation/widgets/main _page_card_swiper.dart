import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/clean_architecture/features/main/domain/entities/movie_entity.dart';

class CardSwiper extends StatelessWidget {
  final List<MovieEntity>? movies;

  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (movies!.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.6,
      child: Swiper(
        itemCount: movies!.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.5,
        itemBuilder: (_, int index) {
          final movie = movies![index];
          return GestureDetector(
            onTap: () {
              print('ID MOVIE ${movie.id}');
              Navigator.pushNamed(context, '/detailsScreen', arguments: movie);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage((movie.posterPath != null)
                    ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                    : 'https://i.stack.imgur.com/GNhxO.png'),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
