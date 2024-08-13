import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models /movie.dart';
import 'package:movie_app/utils/constants.dart';

class TmdbService with ChangeNotifier {
  final String _apiKey = TMDB_API_KEY;
  final String _baseUrl = 'https://api.themoviedb.org/3';

  List<Movie> _movies = [];
  String? _trailerUrl;

  List<Movie> get movies => _movies;
  String? get trailerUrl => _trailerUrl;

  Future<void> fetchPopularMovies() async {
    final response =
        await http.get(Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List movies = data['results'];
      _movies = movies.map((json) => Movie.fromJson(json)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<void> fetchMovieDetails(int movieId) async {
    final response = await http
        .get(Uri.parse('$_baseUrl/movie/$movieId/videos?api_key=$_apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List videos = data['results'];
      if (videos.isNotEmpty) {
        final trailer = videos.firstWhere(
          (video) => video['type'] == 'Trailer',
          orElse: () => {},
        );
        _trailerUrl = trailer['key'];
      }
      notifyListeners();
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http
        .get(Uri.parse('$_baseUrl/search/movie?api_key=$_apiKey&query=$query'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List movies = data['results'];
      return movies.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search movies');
    }
  }
}
