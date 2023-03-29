import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/models.dart';

//para el infinite scroll horizontal cambiamos a statefulwidget
class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final String? title;

  //metodo que se llama cuando se llega al limite del horizontal scroll para que
  //despliegue mas peliculas
  final Function onNextPage;

  const MovieSlider(
      {Key? key, required this.movies, this.title, required this.onNextPage})
      : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
//metodos init y dispose creados para el slider horizontal infinito

//variable creada para saber los valores del slider

  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      /*porque aqui una columna en el child? /porque necesito colocar 
      widgets encima de otros*/
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //se pone el padding aqui para que solo sea el texto el que haga su padding

          if (this.widget.title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.title!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

          SizedBox(height: 1),

          //
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              //scrollDirectio sirve para que las tarjetas vayan en horizontal o vertical
              //segun lo que se requiera luego de los dos puntos se pones AXIS. horizontal o vertical
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (_, int index) => _MoviePoster(widget.movies[index],
                  '${widget.title}-$index-${widget.movies[index].id}'),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  //
  final Movie movie;
  final String heroId;

  const _MoviePoster(this.movie, this.heroId);

  @override
  Widget build(BuildContext context) {
    movie.heroId = heroId;

    return Container(
      width: 130,
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          //
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  width: 130,
                  height: 175,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          //

          Text(
            movie.title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            //el metodo de arriba sirve para que un texto largo se acomode a una ventana pequeña
          ),
        ],
      ),
    );
  }
}
