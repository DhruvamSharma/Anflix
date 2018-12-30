import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:popular_movies/src/models/result.dart';


class MovieApiProvider {

  final _client = Client();
  static final _api_key  = '5d5b4588dc71d0e50c29f2caa9221fa0';
  final _url = 'http://api.themoviedb.org/3/movie/popular?api_key=$_api_key';

  Future<Result> fetchMovieList() async {
    final response = await _client.get(_url);
    if(response.statusCode == 200) {
      return Result.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to  fetch movies');
    }

  }

}