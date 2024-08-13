import 'package:flutter/material.dart';
import '../models /movie.dart';
import 'package:movie_app/screens/movie_details_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;

  MovieTile({required this.movie});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: 'https://image.tmdb.org/t/p/w200${movie.posterPath}',
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.overview),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieDetailsScreen(movie: movie)),
        );
      },
    );
  }
}
