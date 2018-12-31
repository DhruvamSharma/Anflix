import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:popular_movies/src/models/result.dart';


class MovieApiProvider {

  final _client = Client();
  static final _api_key  = '5d5b4588dc71d0e50c29f2caa9221fa0';
  final _url = 'http://api.themoviedb.org/3/movie/popular?api_key=$_api_key';
  final _top_rated= 'http://api.themoviedb.org/3/movie/top_rated?api_key=$_api_key';

  final _similarMoviesListUrl = 'https://api.themoviedb.org/3/discover/movie?api_key=5d5b4588dc71d0e50c29f2caa9221fa0&genres=';


  Future<Result> fetchMovieList() async {
    final response = await _client.get(_url);
    if(response.statusCode == 200) {
      return Result.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to  fetch movies');
    }

  }

  fetchTopRatedMovieList() async {

  }

  Future<Result> fetchMoviesLikeThis(List<int> genreIds) async {

    var genres_list = '';

    for(int i = 0; i< genreIds.length; i++) {
      genres_list += genreIds[i].toString();
      genres_list += ',';
    }

    print('genrelist: '+  genres_list);
    print('\n');
    print(_similarMoviesListUrl+ '{$genres_list}');

    final response = await _client.get(_similarMoviesListUrl+ '{$genres_list}');

    if(response.statusCode == 200) {
      return Result.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to load');
    }

  }


}