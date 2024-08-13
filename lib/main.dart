import 'package:flutter/material.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/services/tmdb_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TmdbService()),
      ],
      child: MaterialApp(
        title: 'Movie App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
          textTheme: const TextTheme(
            headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            bodyLarge: TextStyle(fontSize: 16),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
