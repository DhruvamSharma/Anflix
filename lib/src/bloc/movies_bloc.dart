import 'package:rxdart/rxdart.dart';
import 'package:popular_movies/src/models/result.dart';
import 'package:popular_movies/src/resources/repository/movies_repository.dart';

class MoviesBloc {

  final _moviesRepository = MoviesRepository();
  final _moviesFetcher = PublishSubject<Result>();

  Observable<Result> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    Result model = await _moviesRepository.fetchAllMovies();
    _moviesFetcher.sink.add(model);
  }

  dispose() {
    _moviesFetcher.close();
  }

}

final bloc = MoviesBloc();