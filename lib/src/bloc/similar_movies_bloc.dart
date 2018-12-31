

import 'package:popular_movies/src/models/result.dart';
import 'package:popular_movies/src/resources/repository/movies_repository.dart';

class SimilarMoviesBloc {

  final repository = MoviesRepository();

  Future<Result> fetchAllMovies(genreIds) async => await repository.fetchAllSimilarMovies(genreIds);

}

final bloc = SimilarMoviesBloc();