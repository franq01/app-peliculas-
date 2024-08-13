import 'package:flutter/material.dart';
import 'package:movie_app/services/tmdb_service.dart';
import 'package:movie_app/screens/movie_details_screen.dart';
import 'package:provider/provider.dart';
import '../models /movie.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  Widget buildSuggestions(BuildContext context) {
    final query = this.query;

    if (query.isEmpty) {
      return const Center(child: Text('Search for movies'));
    }

    final tmdbService = Provider.of<TmdbService>(context);

    return FutureBuilder<List<Movie>>(
      future: tmdbService.searchMovies(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return ListTile(
              title: Text(movie.title),
              subtitle: Text(movie.overview),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailsScreen(movie: movie),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(); // Implement if needed
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }
}
