import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_m04/Movies.dart';

class HttpHelper {
  final String _urlKey = "?api_key=25d6d05bf559e0a5e5e5655520f3b9d9";
  final String _urlBase = "https://api.themoviedb.org/3/movie";

  Future<List<Movie>> getMovies(String category) async {
    var url = Uri.parse(_urlBase + category + _urlKey);
    http.Response result = await http.get(url);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];

      if (moviesMap != null) {
        List<Movie> movies = moviesMap.map<Movie>((i) => Movie.fromJson(i)).toList();
        return movies;
      } else {
        throw Exception('No movie data found in the API response');
      }
    } else {
      throw Exception('Failed to load movies. Status Code: ${result.statusCode}');
    }
  }
}