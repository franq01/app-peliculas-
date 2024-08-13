import 'package:flutter/material.dart';
import 'package:movie_app/screens/trailer_screen.dart';
import 'package:movie_app/services/tmdb_service.dart';
import 'package:provider/provider.dart';
import '../models /movie.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;

  MovieDetailsScreen({required this.movie});

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    _fetchMovieDetails();
  }

  Future<void> _fetchMovieDetails() async {
    await Provider.of<TmdbService>(context, listen: false)
        .fetchMovieDetails(widget.movie.id);
  }

  @override
  Widget build(BuildContext context) {
    final tmdbService = Provider.of<TmdbService>(context);
    final trailerUrl = tmdbService.trailerUrl;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.movie.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text(
              widget.movie.overview,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final trailerUrl = tmdbService.trailerUrl;
                if (trailerUrl != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrailerScreen(
                        videoId: trailerUrl,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No trailer available')),
                  );
                }
              },
              child: const Text('Watch Trailer'),
            ),
          ],
        ),
      ),
    );
  }
}
