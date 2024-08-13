import 'package:flutter/material.dart';
import 'package:movie_app/screens/movie_details_screen.dart';
import 'package:movie_app/screens/search_delegate.dart';
import 'package:movie_app/services/tmdb_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TmdbService>(context, listen: false).fetchPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: MovieSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: Consumer<TmdbService>(
        builder: (context, tmdbService, child) {
          return ListView.builder(
            itemCount: tmdbService.movies.length,
            itemBuilder: (context, index) {
              final movie = tmdbService.movies[index];
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
      ),
    );
  }
}
