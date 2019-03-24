import 'package:popular_movies/src/resources/network/move_api_provider.dart';

class MoviesRepository {
  final _movieApiProvider = MovieApiProvider();

  fetchAllMovies() async {
    print("fetching all movies from repo");
    return _movieApiProvider.fetchMovieList();
  }

  fetchAllSimilarMovies(genreIdeas) async {
    print("fetching similar movies from repo");
    return await _movieApiProvider.fetchMoviesLikeThis(genreIdeas);
  }

  fetchTopRatedMovies() async {
    print("fetching top rated movies from repo");
    return await _movieApiProvider.fetchTopRatedMovieList();
  }

}