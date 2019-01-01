import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:popular_movies/src/models/result.dart';
import 'package:popular_movies/src/resources/repository/movies_repository.dart';

class MoviesBloc {

  final _moviesRepository = MoviesRepository();
  final _moviesFetcher = BehaviorSubject<Result>();

  Sink<Result> get allMovies => _fetcherController.sink;
  final _fetcherController = StreamController<Result>();

  Observable<Result> get newResults => _moviesFetcher.stream;

  fetchAllMovies() async {
    Result model = await _moviesRepository.fetchAllMovies();
    allMovies.add(model);
  }

  fetchTopRatedMovies() async{
    Result model = await _moviesRepository.fetchTopRatedMovies();
    print(' i am here: ' + model.results.length.toString());
    allMovies.add(model);
  }

  dispose() {
    _moviesFetcher.close();
    _fetcherController.close();
  }

  MoviesBloc() {
    _fetcherController.stream.listen(_handle);
  }


  void _handle(Result event) {

    _moviesFetcher.add(event);

  }
}

final bloc = MoviesBloc();