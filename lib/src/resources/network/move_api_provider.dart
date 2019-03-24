import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client, Response;
import 'package:popular_movies/src/models/result.dart';


class MovieApiProvider {

  final _client = Client();
  static final _apiKey  = '5d5b4588dc71d0e50c29f2caa9221fa0';
  final _url = 'http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey';
  final _topRated= 'http://api.themoviedb.org/3/movie/top_rated?api_key=$_apiKey';

  final _similarMoviesListUrl = 'https://api.themoviedb.org/3/discover/movie?api_key=5d5b4588dc71d0e50c29f2caa9221fa0&genres=';


  Future<Result> fetchMovieList() async {
    Response response;
    try {
      response = await _client.get(_url);
    } catch(e) {
       response = Response("", 401);
    }
    if(response.statusCode == 200) {
      print("regular movie data fetched from the internet from api provider");
      return Result.fromJson(json.decode(response.body));
    } else {
      return null;
    }

  }

  Future<Result> fetchTopRatedMovieList() async {

    final response = await _client.get(_topRated);
    if(response.statusCode == 200) {
      print("top rated data fetched from the internet from api provider");
      return Result.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to  fetch movies');
    }

  }

  Future<Result> fetchMoviesLikeThis(List<int> genreIds) async {

    var genresList = '';

    for(int i = 0; i< genreIds.length; i++) {
      genresList += genreIds[i].toString();
      genresList += ',';
    }
    final response = await _client.get(_similarMoviesListUrl+ '{$genresList}');
    if(response.statusCode == 200) {
      print("similar movies data fetched from the internet from api provider");
      return Result.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to load');
    }

  }


}