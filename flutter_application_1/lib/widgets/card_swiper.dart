import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/movie.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    ///***esto es para solucionar el error que aparecia cuando apenas estaba cargando
    ///****la imagen...lo que se hace es crear un circulo de carga para que no se vea la
    ///****pantalla roja....esto se crea antes de crear el widget */ */
    if (this.movies.length == 0) {
      ///****esto dice: si la longitud(length) de las peliculas es 0 que muestre el ciculo de carga */
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    //*****creacion de card swiper */
    return Container(
      width: double.infinity,
      height: size.height * 0.6,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.5,
        itemBuilder: (_, int index) {
          //
          final movie = movies[index];

          movie.heroId = 'swiper-${movie.id}';

          // print(movie.fullPosterImg);
          //
          //el fadein Image lo envolvi en otro widget para añadir un border radius
          //y el clipRRect se envolvio en otro widget para ponerle ontap..que es
          //para hacer una navegacion a otra pantalla
          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),

            //el CLIPREECT QUE HABIA AQUI LO ENVOLVI CON UN HERO
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
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
