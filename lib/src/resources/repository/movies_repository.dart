

import 'package:popular_movies/src/resources/network/move_api_provider.dart';

class MoviesRepository {
  final _movieApiProvider = MovieApiProvider();

  fetchAllMovies() async => _movieApiProvider.fetchMovieList();

  fetchAllSimilarMovies(genreIdeas) async => await _movieApiProvider.fetchMoviesLikeThis(genreIdeas);

  fetchTopRatedMovies() async => await _movieApiProvider.fetchTopRatedMovieList();

}