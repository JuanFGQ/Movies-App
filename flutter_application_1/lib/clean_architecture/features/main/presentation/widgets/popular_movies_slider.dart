import 'package:flutter/material.dart';
import 'package:flutter_application_1/clean_architecture/features/main/data/data_sources/remote/movie_api_service.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/popular_movies_bloc/bloc/popular_movies_bloc.dart';
import 'package:flutter_application_1/clean_architecture/features/main/presentation/bloc/popular_movies_bloc/bloc/popular_movies_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/movie_entity.dart';
import '../bloc/popular_movies_bloc/bloc/popular_movies_state.dart';

class PopularMoviesSlider extends StatefulWidget {
  final List<MovieEntity>? movies;
  // final Function onNextPage;

  const PopularMoviesSlider({
    Key? key,
    required this.movies,
    // required this.onNextPage
  }) : super(key: key);

  @override
  State<PopularMoviesSlider> createState() => _PopularMoviesSliderState();
}

class _PopularMoviesSliderState extends State<PopularMoviesSlider> {
  final ScrollController scrollController = ScrollController();
  int popularMoviePage = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (!isLoading &&
          scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 500) {
        isLoading = true;
        popularMoviePage++;
        final getMorePopularPages = BlocProvider.of<PopularMoviesBloc>(context);
        getMorePopularPages.add(GetPopularMovies(pageNum: popularMoviePage));

        getMorePopularPages.stream.listen((state) {
          if (state is PopularMoviesDone || state is PopularMoviesError) {
            isLoading = false;
          }
        });
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies!.length,
              itemBuilder: (_, int index) => _MoviePoster(
                widget.movies![index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  //
  final MovieEntity movie;
  // final String heroId;

  const _MoviePoster(
    this.movie,
  );

  @override
  Widget build(BuildContext context) {
    // final desestrucMovieModel = movie.results;
    // movie.heroId = heroId;

    return Container(
      width: 130,
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          //
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/detailsScreen',
                arguments: movie),
            // child:

            // Hero(
            //   tag: movie.heroId!,
            child: Hero(
              tag: 'search-${movie.id!}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage((movie.posterPath != null)
                      ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                      : 'https://i.stack.imgur.com/GNhxO.png'),
                  width: 130,
                  height: 175,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // ),

          //

          Text(
            movie.title!,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
